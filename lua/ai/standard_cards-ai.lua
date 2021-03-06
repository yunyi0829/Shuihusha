local function hasExplicitRebel(room)
	for _, player in sgs.qlist(room:getAllPlayers()) do
		if sgs.isRolePredictable() and  sgs.evaluatePlayerRole(player) == "rebel" then return true end
		if sgs.compareRoleEvaluation(player, "rebel", "loyalist") == "rebel" then return true end
	end
	return false
end

local function hasGoldArmor(self, enemy)
	if enemy:hasSkill("jinjia") and not enemy:getArmor() then
		return true
	end
	return self:isEquip("GoldArmor", enemy)
end

function SmartAI:slashProhibit(card,enemy,from)
	from = from or self.player
	card = card or sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
	for _, askill in sgs.qlist(enemy:getVisibleSkillList()) do
		local filter = sgs.ai_slash_prohibit[askill:objectName()]
		if filter and type(filter) == "function" and filter(self, enemy, card) then return true end
	end

	if card:isKindOf("NatureSlash") and hasGoldArmor(self, enemy) then
		return true
	end
	if self:isFriend(enemy) then
		if card:isKindOf("FireSlash") or from:hasWeapon("fan") or from:hasSkill("fenhui") then
			if self:isEquip("Vine", enemy) and not (enemy:isChained() and self:isGoodChainTarget(enemy)) then return true end
		end
		if enemy:isChained() and (card:isKindOf("NatureSlash") or self:hasSkills("fenhui|paohong")) and not self:isGoodChainTarget(enemy) and
			self:slashIsEffective(card,enemy) then return true end
		if self:getCardsNum("Jink",enemy) == 0 and enemy:getHp() < 2 and self:slashIsEffective(card,enemy) then return true end
		if enemy:isLord() and self:isWeak(enemy) and self:slashIsEffective(card,enemy) then return true end
		if self:isEquip("GudingBlade") and enemy:isKongcheng() then return true end
		if enemy:hasSkill("jintang") and enemy:getHp() == 1 and (card:isKindOf("NatureSlash") or from:hasWeapon("fan")) then
			return true
		end
	else
		if enemy:isChained() and not self:isGoodChainTarget(enemy) and self:slashIsEffective(card,enemy)
			and (card:isKindOf("NatureSlash") or from:hasSkill("fenhui")) then
			return true
		end
		if enemy:hasSkill("jintang") and enemy:getHp() == 1 and not card:isKindOf("NatureSlash") and not from:hasWeapon("fan") then
			return true
		end
	end

	return self.room:isProhibited(from, enemy, card) or not self:slashIsEffective(card, enemy)
end

function SmartAI:slashIsEffective(slash, to, from)
	from = from or self.player
	if to:hasSkill("jueming") and to:getHp() == 1 then
		return false
	end
	if to:hasSkill("jintang") and to:getHp() == 1 and not slash:isKindOf("NatureSlash") then
		return false
	end
	if to:hasSkill("qianshui") and not from:getWeapon() then
		return false
	end
	if to:hasSkill("liushou") and not to:faceUp() then
		return false
	end

	local natures = {
		Slash = sgs.DamageStruct_Normal,
		FireSlash = sgs.DamageStruct_Fire,
		ThunderSlash = sgs.DamageStruct_Thunder,
	}

	local nature = natures[slash:className()]
	if from:hasSkill("fenhui") and nature ~= sgs.DamageStruct_Thunder then
		nature = sgs.DamageStruct_Fire
	end
	if not self:damageIsEffective(to, nature) then return false end

	if from:isPenetrated() then
		return true
	end

	local armor = to:getArmor()
	if armor then
		if armor:objectName() == "renwang_shield" then
			return not slash:isBlack()
		elseif armor:objectName() == "vine" then
			return nature ~= sgs.DamageStruct_Normal or from:hasWeapon("fan")
		elseif armor:objectName() == "gold_armor" then
			return not from:getWeapon() and nature == sgs.DamageStruct_Normal
		end
	end

	return true
end

function SmartAI:slashIsAvailable(player)
	player = player or self.player
	local slash = self:getCard("Slash", player) or sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
	assert(slash)
	return slash:isAvailable(player)
end

function SmartAI:useCardSlash(card, use)
	if not self:slashIsAvailable() then return end
	local no_distance = self.slash_distance_limit
	if self.player:getAttackRange(nil, card) > 200 then no_distance = true end
	self.slash_targets = self.player:getSlashTarget(nil, card)

	self.predictedRange = self.player:getAttackRange()
	if self.player:hasSkill("jishi") and self:isWeak() and self:getOverflow() == 0 then return end
	for _, friend in ipairs(self.friends_noself) do
		local slash_prohibit = false
		slash_prohibit = self:slashProhibit(card,friend)
		if (self.player:hasSkill("qiangqu") and friend:isFemale() and friend:isWounded() and not friend:isNude())
		or (friend:hasSkill("kongying")
		and (self:getCardsNum("Jink", friend) > 0 or (not self:isWeak(friend) and self:isEquip("EightDiagram",friend)))
		and (hasExplicitRebel(self.room) or not friend:isLord()))
		then
			if not slash_prohibit then
				if ((self.player:canSlash(friend, card, not no_distance)) or
					(use.isDummy and (self.player:distanceTo(friend) <= self.predictedRange))) and
					self:slashIsEffective(card, friend) then
					use.card = card
					if use.to then
						use.to:append(friend)
						self:speak("hostile")
						if self.slash_targets <= use.to:length() then return end
					end
				end
			end
		end
	end

	local targets = {}
	local ptarget = self:getPriorTarget()
	if ptarget and not self:slashProhibit(card, ptarget) then
		table.insert(targets, ptarget)
	end
	self:sort(self.enemies, "defense")
	for _, enemy in ipairs(self.enemies) do
		local slash_prohibit = false
		slash_prohibit = self:slashProhibit(card,enemy)
		if not slash_prohibit and enemy:objectName() ~= ptarget:objectName() then
			table.insert(targets, enemy)
		end
	end

	self.mi_targets = 1
	if self.player:hasSkill("xiayao") then self.mi_targets = self.mi_targets + 1 end
	for _, target in ipairs(targets) do
		local canliuli = false
		if (self.player:canSlash(target, card, not no_distance) or
		(use.isDummy and self.predictedRange and (self.player:distanceTo(target) <= self.predictedRange))) and
		self:objectiveLevel(target) > 3
		and self:slashIsEffective(card, target) then
			-- fill the card use struct
			local usecard = card
			local mi = self:searchForEcstasy(use,target,card)
			if mi and self:getCardsNum("Jink", target) > 0 and self:getCardId("Slash") and self:slashIsAvailable() then
				use.card = mi
				if use.to and use.to:length() < self.mi_targets then use.to:append(target) end
				return
			end
			if not use.to or use.to:isEmpty() then
				local anal = self:searchForAnaleptic(use,target,card)
				if anal and self:isNoZhenshaMark() and not hasSilverLion(target) and not self:isWeak() then
					if anal:getEffectiveId() ~= card:getEffectiveId() then use.card = anal return end
				end
				local equips = self:getCards("EquipCard", self.player, "h")
				for _, equip in ipairs(equips) do
					local callback = sgs.ai_slash_weaponfilter[equip:objectName()]
					if callback and type(callback) == "function" and callback(target, self) and
						self.player:distanceTo(target) <= (sgs.weapon_range[equip:className()] or 0) then
						self:useEquipCard(equip, use)
						if use.card then return end
					end
				end
		--[[	if self.player:hasSkill("guibing") then
					use.card = guibing_skill.getTurnUseCard(self)
				else]]if self.player:hasSkill("houfa") then
					use.card = houfa_skill.getTurnUseCard(self, true)
				elseif self.player:hasSkill("douzhan") then
					use.card = douzhan_skill.getTurnUseCard(self, true)
		--		elseif self.player:hasSkill("strike") then
		--			use.card = strike_skill.getTurnUseCard(self, true)
				end
				if target:isChained() and self:isGoodChainTarget(target) and not use.card then
					if self:isEquip("Crossbow") and card:isKindOf("NatureSlash") then
						local slashes = self:getCards("Slash")
						for _, slash in ipairs(slashes) do
							if not slash:isKindOf("NatureSlash") and self:slashIsEffective(slash, target)
								and not self:slashProhibit(slash, target) then
								usecard = slash
								break
							end
						end
					elseif not card:isKindOf("NatureSlash") then
						local slash = self:getCard("NatureSlash")
						if slash and self:slashIsEffective(slash, target) and not self:slashProhibit(slash, target) then usecard = slash end
					end
				end
			end
			use.card = use.card or usecard
			if use.to and not use.to:contains(target) then
				use.to:append(target)
				if self.slash_targets <= use.to:length() then return end
			end
		end
	end

	for _, friend in ipairs(self.friends_noself) do
		if friend:hasSkill("longluo") and friend:getHp() > 1 and
			not (friend:containsTrick("indulgence", false) or friend:containsTrick("supply_shortage", false)) then
			local slash_prohibit = false
			slash_prohibit = self:slashProhibit(card, friend)
			if not slash_prohibit then
				if ((self.player:canSlash(friend, card, not no_distance)) or
					(use.isDummy and (self.player:distanceTo(friend) <= self.predictedRange))) and
					self:slashIsEffective(card, friend) then
					use.card = card
					if use.to then
						use.to:append(friend)
						if self.slash_targets <= use.to:length() then return end
					end
				end
			end
		end
	end
end

sgs.ai_skill_use.slash = function(self, prompt)
--	if prompt ~= "@askforslash" then return "." end
	local slash = self:getCard("Slash")
	if not slash then return "." end
	for _, enemy in ipairs(self.enemies) do
		if self.player:canSlash(enemy, slash, true) and not self:slashProhibit(slash, enemy) and self:slashIsEffective(slash, enemy) then
			return ("%s->%s"):format(slash:toString(), enemy:objectName())
		end
	end
	return "."
end

sgs.ai_skill_playerchosen.zero_card_as_slash = function(self, targets)
	local slash = sgs.Sanguosha:cloneCard("slash", sgs.Card_NoSuit, 0)
	local targetlist=sgs.QList2Table(targets)
	self:sort(targetlist, "defense")
	for _, target in ipairs(targetlist) do
		if self:isEnemy(target) and not self:slashProhibit(slash ,target) and self:slashIsEffective(slash,target) then
			return target
		end
	end
	for i=#targetlist, 1, -1 do
		if not self:slashProhibit(slash, targetlist[i]) then
			return targetlist[i]
		end
	end
	return targets:first()
end

sgs.ai_card_intention.Slash = function(card,from,tos,self)
--	if from:objectName() ~= source:objectName() then return end
	for _, to in ipairs(tos) do
		local value = 80
		if sgs.ai_collateral then sgs.ai_collateral=false value = 0 end

		self:speakTrigger(card,from,to)
		if to:hasSkill("baoguo") then
			-- value = value*(2-to:getHp())/1.1
			value = math.max(value*(2-to:getHp())/1.1, 0)
		end
		if from:hasSkill("dujian") and to:getHp() > 3 then value = 0 end
		sgs.updateIntention(from, to, value)
	end
end

sgs.ai_skill_cardask["slash-jink"] = function(self, data, pattern, target)
	local effect = data:toSlashEffect()
	local cards = sgs.QList2Table(self.player:getHandcards())
	if sgs.ai_skill_cardask.nullfilter(self, data, pattern, target) then return "." end
	--if not target then self.room:writeToConsole(debug.traceback()) end
	if not target then return end
	if self:isFriend(target) then
		if target:hasSkill("yixian") and not self.player:faceUp() then return "." end
		if target:hasSkill("huatian") then return "." end
		if self.player:isChained() and self:isGoodChainTarget(self.player) then return "." end
	else
		if not target:hasFlag("drank") then
			if target:hasSkill("tongwu") and self.player:getHp() > 2 and self:getCardsNum("Jink") > 0 then return "." end
		else
			return self:getCardId("Jink") or "."
		end
		if not (self.player:getHandcardNum() == 1 and self:hasSkills(sgs.need_kongcheng)) and not target:hasSkill("duoming") then
			if self:isEquip("Axe", target) then
				if self:hasSkills(sgs.lose_equip_skill, target) and target:getEquips():length() > 1 then return "." end
				if target:getHandcardNum() - target:getHp() > 2 then return "." end
			elseif self:isEquip("Blade", target) then
				if self:getCardsNum("Jink") <= self:getCardsNum("Slash", target) then return "." end
			end
		end
	end
end

sgs.dynamic_value.damage_card.Slash = true

sgs.ai_use_value.Slash = 4.6
sgs.ai_keep_value.Slash = 2
sgs.ai_use_priority.Slash = 2.4

function SmartAI:useCardPeach(card, use)
	local mustusepeach = false
	if not self.player:isWounded() then return end
	local peaches = 0
	local cards = self.player:getHandcards()
	cards = sgs.QList2Table(cards)
	for _,card in ipairs(cards) do
		if card:isKindOf("Peach") then peaches = peaches+1 end
	end
	for _, friend in ipairs(self.enemies) do
		if (self:hasSkills(sgs.drawpeach_skill,enemy) and self.player:getHandcardNum() < 3) then
			mustusepeach = true
		end
	end
	for _, friend in ipairs(self.friends_noself) do
		if not mustusepeach then
			if friend:isLord() and friend:getHp() == 1 and peaches < 2 then return end
			if (self.player:getHp()-friend:getHp() > peaches) and (friend:getHp() < 3) then return end
		end
	end

	if self.player:hasSkill("meihuo") and self:getOverflow() > 0 then
		self:sort(self.friends, "hp")
		for _, friend in ipairs(self.friends) do
			if friend:isWounded() and friend:isMale() then return end
		end
	end

	use.card = card
end

sgs.ai_card_intention.Peach = -120

sgs.ai_use_value.Peach = 6
sgs.ai_keep_value.Peach = 5
sgs.ai_use_priority.Peach = 4.1

sgs.ai_use_value.Jink = 8.9
sgs.ai_keep_value.Jink = 4

sgs.dynamic_value.benefit.Peach = true

sgs.weapon_range.Crossbow = 1
sgs.weapon_range.DoubleSword = 2
sgs.weapon_range.QinggangSword = 2
sgs.weapon_range.IceSword = 2
sgs.weapon_range.GudingBlade = 2
sgs.weapon_range.Axe = 3
sgs.weapon_range.Blade = 3
sgs.weapon_range.Spear = 3
sgs.weapon_range.Halberd = 4
sgs.weapon_range.KylinBow = 5

sgs.ai_skill_invoke.double_sword = true

function sgs.ai_slash_weaponfilter.double_sword(to, self)
	return self.player:getGender()~=to:getGender()
end

function sgs.ai_weapon_value.double_sword(self, enemy)
	if enemy and enemy:isMale() ~= self.player:isMale() then return 3 end
end

sgs.ai_skill_cardask["double-sword-card"] = function(self, data, pattern, target)
	if target and self:isFriend(target) then return "." end
	local cards = self.player:getHandcards()
	for _, card in sgs.qlist(cards) do
		if card:isKindOf("Slash") or card:isKindOf("Shit") or card:isKindOf("Collateral") or card:isKindOf("GodSalvation")
		or card:isKindOf("Disaster") or card:isKindOf("EquipCard") or card:isKindOf("AmazingGrace") then
			return "$"..card:getEffectiveId()
		end
	end
	return "."
end

function sgs.ai_weapon_value.qinggang_sword(self, enemy)
	if enemy and enemy:getArmor() then return 3 end
end

sgs.ai_skill_invoke.ice_sword=function(self, data)
	local damage = data:toDamage()
	local target = damage.to
	if damage.card:hasFlag("drank") then return false end
	if self:isFriend(target) then
		if self:isWeak(target) then return true
		elseif target:getLostHp()<1 then return false end
		return true
	else
		if self:isWeak(target) then return false end
		if target:getArmor() and self:evaluateArmor(target:getArmor(), target)>3 then return true end
		local num = target:getHandcardNum()
		if self.player:hasSkill("tieji") or (self.player:hasSkill("liegong")
			and (num >= self.player:getHp() or num <= self.player:getAttackRange())) then return false end
		if target:hasSkill("tuntian") then return false end
		if self:hasSkills(sgs.need_kongcheng, target) then return false end
		if target:getCards("he"):length()<4 and target:getCards("he"):length()>1 then return true end
		return false
	end
end

function sgs.ai_slash_weaponfilter.guding_blade(to)
	return to:isKongcheng()
end

function sgs.ai_weapon_value.guding_blade(self, enemy)
	if not enemy then return end
	local value = 2
	if enemy:getHandcardNum() < 1 then value = 4 end
	return value
end

sgs.ai_skill_cardask["@axe"] = function(self, data, pattern, target)
	if target and self:isFriend(target) then return "." end
	local effect = data:toSlashEffect()
	local allcards = self.player:getCards("he")
	allcards = sgs.QList2Table(allcards)
	if effect.slash:hasFlag("drank") or #allcards-2 >= self.player:getHp() or (self.player:hasSkill("kuanggu") and self.player:isWounded()) then
		local cards = self.player:getCards("h")
		cards = sgs.QList2Table(cards)
		local index
		if self:hasSkills(sgs.need_kongcheng) then index = #cards end
		if self.player:getOffensiveHorse() then
			if index then
				if index < 2 then
					index = index + 1
					table.insert(cards, self.player:getOffensiveHorse())
				end
			end
			table.insert(cards, self.player:getOffensiveHorse())
		end
		if self.player:getArmor() then
			if index then
				if index < 2 then
					index = index + 1
					table.insert(cards, self.player:getArmor())
				end
			end
			table.insert(cards, self.player:getArmor())
		end
		if self.player:getDefensiveHorse() then
			if index then
				if index < 2 then
					index = index + 1
					table.insert(cards, self.player:getDefensiveHorse())
				end
			end
			table.insert(cards, self.player:getDefensiveHorse())
		end
		if #cards >= 2 then
			self:sortByUseValue(cards, true)
			return "$"..cards[1]:getEffectiveId().."+"..cards[2]:getEffectiveId()
		end
	end
end

function sgs.ai_slash_weaponfilter.axe(to, self)
	return self:getOverflow() > 0
end

function sgs.ai_weapon_value.axe(self, enemy)
	if self:hasSkills("manli|liba|meicha|juesi|dujian",self.player) then return 6 end
	if enemy and enemy:getHp() < 3 then return 3 - enemy:getHp() end
end

sgs.ai_skill_cardask["blade-slash"] = function(self, data, pattern, target)
	if target and self:isFriend(target) and not (target:hasSkill("leiji") and self:getCardsNum("Jink", target, "h") > 0) then
		return "."
	end
	for _, slash in ipairs(self:getCards("Slash")) do
		if self:slashIsEffective(slash, target) then
			return slash:toString()
		end
	end
	return "."
end

function sgs.ai_weapon_value.blade(self, enemy)
	if not enemy then return self:getCardsNum("Slash") end
end

function sgs.ai_cardsview.spear(class_name, player)
	if class_name == "Slash" then
		local cards = player:getCards("he")
		cards = sgs.QList2Table(cards)
		for _, acard in ipairs(cards) do
			if acard:isKindOf("Slash") then return end
		end
		local cards = player:getCards("h")
		cards=sgs.QList2Table(cards)
		local newcards = {}
		for _, card in ipairs(cards) do
			if not card:isKindOf("Peach") then table.insert(newcards, card) end
		end
		if #newcards<(player:getHp()+1) then return nil end
		if #newcards<2 then return nil end

		local suit1 = newcards[1]:getSuitString()
		local card_id1 = newcards[1]:getEffectiveId()

		local suit2 = newcards[2]:getSuitString()
		local card_id2 = newcards[2]:getEffectiveId()

		local suit="no_suit"
		if newcards[1]:isBlack() == newcards[2]:isBlack() then suit = suit1 end

		local card_str = ("slash:spear[%s:%s]=%d+%d"):format(suit, 0, card_id1, card_id2)

		return card_str
	end
end

local spear_skill={}
spear_skill.name="spear"
table.insert(sgs.ai_skills,spear_skill)
spear_skill.getTurnUseCard=function(self,inclusive)
	local cards = self.player:getCards("h")
	cards=sgs.QList2Table(cards)

	if #cards<(self.player:getHp()+1) then return nil end
	if #cards<2 then return nil end

	self:sortByUseValue(cards,true)

	local suit1 = cards[1]:getSuitString()
	local card_id1 = cards[1]:getEffectiveId()

	local suit2 = cards[2]:getSuitString()
	local card_id2 = cards[2]:getEffectiveId()

	local suit="no_suit"
	if cards[1]:isBlack() == cards[2]:isBlack() then suit = suit1 end

	local card_str = ("slash:spear[%s:%s]=%d+%d"):format(suit, 0, card_id1, card_id2)

	local slash = sgs.Card_Parse(card_str)

	return slash
end

function sgs.ai_slash_weaponfilter.fan(to)
	local armor = to:getArmor()
	return armor and (armor:isKindOf("Vine") or armor:isKindOf("GaleShell"))
end

sgs.ai_skill_invoke.kylin_bow = function(self, data)
	local damage = data:toDamage()

	if self:hasSkills(sgs.lose_equip_skill, damage.to) then
		return self:isFriend(damage.to)
	end

	return self:isEnemy(damage.to)
end

function sgs.ai_slash_weaponfilter.kylin_bow(to)
	if to:getDefensiveHorse() then return true else return false end
end

function sgs.ai_weapon_value.kylin_bow(self, target)
	if not target then
		for _, enemy in ipairs(self.enemies) do
			if enemy:getOffensiveHorse() or enemy:getDefensiveHorse() then return 1 end
		end
	end
end

sgs.ai_skill_invoke.eight_diagram = function(self, data)
	if self.player:hasSkill("yueli") then return true end
	if self:getDamagedEffects(self) then return false end
	return true
end

function sgs.ai_armor_value.eight_diagram(player, self)
	local haszj = self:hasSkills("kongying", self:getEnemies(player))
	if haszj then
		return 2
	end
	if player:hasSkill("yueli") then
		return 5
	end
	return 4
end

function sgs.ai_armor_value.renwang_shield()
	return 4
end

function sgs.ai_armor_value.silver_lion(player, self)
	if self:hasWizard(self:getEnemies(player), true) then
		for _, player in sgs.qlist(self.room:getAlivePlayers()) do
			if player:containsTrick("lightning", false) then return 5 end
		end
	end
	return 1
end

sgs.ai_use_priority.OffensiveHorse = 2.69
sgs.ai_use_priority.Halberd = 2.685
sgs.ai_use_priority.KylinBow = 2.68
sgs.ai_use_priority.Blade = 2.675
sgs.ai_use_priority.GudingBlade = 2.67
sgs.ai_use_priority.DoubleSword =2.665
sgs.ai_use_priority.Spear = 2.66
sgs.ai_use_priority.IceSword = 2.65
sgs.ai_use_priority.QinggangSword = 2.645
sgs.ai_use_priority.Axe = 2.64
sgs.ai_use_priority.Crossbow = 2.63
sgs.ai_use_priority.SilverLion = 0.9
sgs.ai_use_priority.EightDiagram = 0.8
sgs.ai_use_priority.RenwangShield = 0.7
sgs.ai_use_priority.DefensiveHorse = 0

sgs.dynamic_value.damage_card.ArcheryAttack = true
sgs.dynamic_value.damage_card.SavageAssault = true

sgs.ai_use_value.ArcheryAttack = 3.8
sgs.ai_use_priority.ArcheryAttack = 3.5
sgs.ai_use_value.SavageAssault = 3.9
sgs.ai_use_priority.SavageAssault = 3.5

sgs.ai_skill_cardask.aoe = function(self, data, pattern, target, name)
	if sgs.ai_skill_cardask.nullfilter(self, data, pattern, target) then return "." end
	if not self:damageIsEffective(nil, nil, target) then return "." end
end

sgs.ai_skill_cardask["savage-assault-slash"] = function(self, data, pattern, target)
	local effect = data:toCardEffect()
	self:speakTrigger(effect.card,effect.from,effect.to)
	return sgs.ai_skill_cardask.aoe(self, data, pattern, target, "savage_assault")
end

sgs.ai_skill_cardask["archery-attack-jink"] = function(self, data, pattern, target)
	local effect = data:toCardEffect()
	if effect.from:hasSkill("lianzhu") and self:getCardsNum("Jink") == 1 then return "." end
	return sgs.ai_skill_cardask.aoe(self, data, pattern, target, "archery_attack")
end

sgs.ai_keep_value.Nullification = 3
sgs.ai_use_value.Nullification = 8

function SmartAI:useCardAmazingGrace(card, use)
	if #self.friends >= #self.enemies or (self:hasSkills(sgs.need_kongcheng) and self.player:getHandcardNum() == 1)
		or self.player:hasSkill("longjiao") then
		use.card = card
		if not use.isDummy then
			self:speak("amazing_grace")
		end
	end
end

sgs.ai_use_value.AmazingGrace = 3
sgs.ai_keep_value.AmazingGrace = -1
sgs.ai_use_priority.AmazingGrace = 1

function SmartAI:useCardGodSalvation(card, use)
	local good, bad = 0, 0

	for _, friend in ipairs(self.friends) do
		if friend:isWounded() then
			good = good + 10/(friend:getHp())
			if friend:isLord() then good = good + 10/(friend:getHp()) end
		end
	end

	for _, enemy in ipairs(self.enemies) do
		if enemy:isWounded() then
			bad = bad + 10/(enemy:getHp())
			if enemy:isLord() then
				bad = bad + 10/(enemy:getHp())
			end
		end
	end

	if good > bad then
		use.card = card
		if not use.isDummy then
			self:speak("god_salvation")
		end
	end
end

sgs.ai_use_priority.GodSalvation = 3.9
sgs.dynamic_value.benefit.GodSalvation = true

local function factorial(n)
	if n <= 0.1 then return 1 end
	return n*factorial(n-1)
end

function SmartAI:useCardDuel(duel, use)
	self:sort(self.enemies,"handcard")
	local enemies = self:exclude(self.enemies, duel)
	local friends = self:exclude(self.friends_noself, duel)
	local target
	local n1 = self:getCardsNum("Slash")
	if self.player:hasSkill("wushuang") then n1 = n1 * 2 end
	local ptarget = self:getPriorTarget()
	if ptarget then
		local target = ptarget
		local n2 = target:getHandcardNum()
		if target:hasSkill("wushuang") then n2 = n2*2 end
		local useduel
		if target and self:objectiveLevel(target) > 3 and self:hasTrickEffective(duel, target)
			and not self:cantbeHurt(target) then
			if n1 >= n2 then
				useduel = true
			elseif n2 > n1*2 + 1 then
				useduel = false
			elseif n1 > 0 then
				local percard = 0.35
				if self:canPaoxiao(target) then percard = 0.2 end
				local poss = percard ^ n1 * (factorial(n1)/factorial(n2)/factorial(n1-n2))
				if math.random() > poss then useduel = true end
			end
			if useduel then
				use.card = duel
				if use.to then
					use.to:append(target)
					self:speak("duel")
				end
				return
			end
		end
	end
	local n2
	for _, enemy in ipairs(enemies) do
		n2 = self:getCardsNum("Slash",enemy)
		if self:objectiveLevel(enemy) > 3 then
			if enemy:hasSkill("wushuang") then n2 = n2*2 end
			target = enemy
			break
		end
	end

	local useduel
	if target and self:objectiveLevel(target) > 3 and self:hasTrickEffective(duel, target)
		and not self.room:isProhibited(self.player, target, duel)
			and not self:cantbeHurt(target) then
		if n1 >= n2 then
			useduel = true
		elseif n2 > n1*2 + 1 then
			useduel = false
		elseif n1 > 0 then
			local percard = 0.35
			if self:canPaoxiao(target) then percard = 0.2 end
			local poss = percard ^ n1 * (factorial(n1)/factorial(n2)/factorial(n1-n2))
			if math.random() > poss then useduel = true end
		end
		if useduel then
			use.card = duel
			if use.to then
				use.to:append(target)
				self:speak("duel")
			end
			return
		end
	end
end

sgs.ai_card_intention.Duel=function(card,from,tos,source)
	sgs.updateIntentions(from, tos, 80)
end

sgs.ai_use_value.Duel = 3.7
sgs.ai_use_priority.Duel = 2.9

sgs.dynamic_value.damage_card.Duel = true

sgs.ai_skill_cardask["duel-slash"] = function(self, data, pattern, target)
	if sgs.ai_skill_cardask.nullfilter(self, data, pattern, target) then return "." end
	if (not self:isFriend(target) and self:getCardsNum("Slash")*2 >= target:getHandcardNum())
		or (target:getHp() > 2 and self.player:getHp() <= 1 and self:getCardsNum("Peach") == 0 and not self.player:hasSkill("buqu")) then
		return self:getCardId("Slash")
	else return "." end
end

function SmartAI:useCardExNihilo(card, use)
	use.card = card
	if not use.isDummy then
		self:speak("lucky")
	end
end

sgs.ai_card_intention.ExNihilo = -80

sgs.ai_keep_value.ExNihilo = 3.6
sgs.ai_use_value.ExNihilo = 10
sgs.ai_use_priority.ExNihilo = 6

sgs.dynamic_value.benefit.ExNihilo = true

function SmartAI:getDangerousCard(who)
	local weapon = who:getWeapon()
	if (weapon and weapon:isKindOf("Crossbow")) then return  weapon:getEffectiveId() end
	if (weapon and weapon:isKindOf("Spear") and who:hasSkill("shalu"))  then return  weapon:getEffectiveId() end
	if (weapon and weapon:isKindOf("Axe") and self:hasSkills("manli|liba|meicha|juesi", who)) then return weapon:getEffectiveId() end
	if (who:getArmor() and who:hasEquip("eight_diagram") and who:getArmor():getSuit() == sgs.Card_Spade and who:hasSkill("kongying")) then return who:getArmor():getEffectiveId() end
end

function SmartAI:getValuableCard(who)
	local weapon = who:getWeapon()
	local armor = who:getArmor()
	local offhorse = who:getOffensiveHorse()
	local defhorse = who:getDefensiveHorse()
	self:sort(self.friends, "hp")
	local friend
	if #self.friends > 0 then friend = self.friends[1] end
	if friend and self:isWeak(friend) and who:inMyAttackRange(friend) then
		if weapon and who:distanceTo(friend) > 1 then return weapon:getEffectiveId() end
		if offhorse and who:distanceTo(friend) > 1 then return offhorse:getEffectiveId() end
	end

	if defhorse then
		for _,friend in ipairs(self.friends) do
			if friend:distanceTo(who) == friend:getAttackRange()+1 then
				return defhorse:getEffectiveId()
			end
		end
	end

	if armor and self:evaluateArmor(armor,who)>3 then
		return armor:getEffectiveId()
	end

	if self:isEquip("Saru", who) then
		return offhorse:getEffectiveId()
	end

	local equips = sgs.QList2Table(who:getEquips())
	for _,equip in ipairs(equips) do
		if self:hasSkills("xiagu|zhiqu-n|zhiqu-c|huxiao|shexin|maiyi", who) then return equip:getEffectiveId() end
		if self:hasSkills("feiqiang|maidao|yinlang", who) and equip:isKindOf("Weapon") then return equip:getEffectiveId() end
	end

	if armor and self:evaluateArmor(armor, who)>0
		and not (armor:isKindOf("SilverLion") and who:isWounded()) then
		return armor:getEffectiveId()
	end

	if weapon then
		if not (who:hasSkill("cuihuo") and (who:getHandcardNum() >= who:getHp())) then
			for _,friend in ipairs(self.friends) do
				if ((who:distanceTo(friend) <= who:getAttackRange()) and (who:distanceTo(friend) > 1)) then
					return weapon:getEffectiveId()
				end
			end
		end
	end

	if offhorse then
		if who:hasSkill("xiaoji") and who:getHandcardNum() >= who:getHp() then
		else
			for _,friend in ipairs(self.friends) do
				if who:distanceTo(friend) == who:getAttackRange() and
				who:getAttackRange() > 1 then
					return offhorse:getEffectiveId()
				end
			end
		end
	end
end

function SmartAI:useCardSnatchOrDismantlement(card, use)
	local name = card:objectName()
	local players = self.room:getOtherPlayers(self.player)
	local tricks
	players = self:exclude(players, card)
	for _, player in ipairs(players) do
		if player:containsTrick("lightning", false) and self:getFinalRetrial(player) ==2 and self:hasTrickEffective(card, player) then
			use.card = card
			if use.to then
				tricks = player:getCards("j")
				for _, trick in sgs.qlist(tricks) do
					if trick:isKindOf("Lightning") then
						sgs.ai_skill_cardchosen[name] = trick:getEffectiveId()
					end
				end
				use.to:append(player)
			end
			return
		end
	end

	self:sort(self.enemies,"defense")
	if #self.enemies > 0 and sgs.getDefense(self.enemies[1]) >= 8 then self:sort(self.enemies, "threat") end
	local enemies = self:exclude(self.enemies, card)
	self:sort(self.friends_noself,"defense")
	local friends = self:exclude(self.friends_noself, card)
	local hasLion, target
	for _, enemy in ipairs(enemies) do
		if not enemy:isNude() and self:hasTrickEffective(card, enemy) then
			if self:getDangerousCard(enemy) then
				use.card = card
				if use.to then
					sgs.ai_skill_cardchosen[name] = self:getDangerousCard(enemy)
					use.to:append(enemy)
					self:speak("hostile")
				end
				return
			end
		end
	end

	for _, friend in ipairs(friends) do
		if (friend:containsTrick("indulgence", false) or friend:containsTrick("supply_shortage", false)) and self:hasTrickEffective(card, friend) then
			use.card = card
			if use.to then
				tricks = friend:delayedTricks()
				for _, trick in sgs.qlist(tricks) do
					if trick:isKindOf("Indulgence") then
						if friend:getHp() < friend:getHandcardNum() then
							sgs.ai_skill_cardchosen[name] = trick:getEffectiveId()
						end
					end
					if trick:isKindOf("SupplyShortage") then
						sgs.ai_skill_cardchosen[name] = trick:getEffectiveId()
					end
					if trick:isKindOf("Indulgence") then
						sgs.ai_skill_cardchosen[name] = trick:getEffectiveId()
					end
				end
				use.to:append(friend)
			end
			return
		end
		if self:isEquip("SilverLion", friend) and self:hasTrickEffective(card, friend) and
			friend:isWounded() then
			hasLion = true
			target = friend
		end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:isNude() and self:hasTrickEffective(card, enemy) then
			if self:getValuableCard(enemy) then
				use.card = card
				if use.to then
					sgs.ai_skill_cardchosen[name] = self:getValuableCard(enemy)
					use.to:append(enemy)
					self:speak("hostile")
				end
				return
			end
		end
	end

	--[[for _, enemy in ipairs(enemies) do
		if not enemy:isNude() and self:hasTrickEffective(card, enemy) and not self:needKongcheng(enemy) and not enemy:hasSkill("kongcheng") then
			if enemy:getHandcardNum() == 1 then
				use.card = card
				if use.to then
					sgs.ai_skill_cardchosen[name] = self:getCardRandomly(enemy, "h")
					use.to:append(enemy)
					self:speak("hostile")
				end
				return
			end
		end
	end]]

	if hasLion then
		use.card = card
		if use.to then
			sgs.ai_skill_cardchosen[name] = target:getArmor():getEffectiveId()
			use.to:append(target)
		end
		return
	end

	if name == "snatch" or self:getOverflow() > 0 then
		for _, enemy in ipairs(enemies) do
			local equips = enemy:getEquips()
			if not enemy:isNude() and self:hasTrickEffective(card, enemy) and
				not (self:hasSkills(sgs.lose_equip_skill, enemy) and enemy:getHandcardNum() == 0) and
				not (enemy:getCards("he"):length() == 1 and self:isEquip("GaleShell",enemy)) then
				if enemy:getHandcardNum() == 1 then
					if enemy:hasSkill("kongmen") or enemy:hasLordSkill("zhiyuan") then return end
				end
				if self:hasSkills(sgs.cardneed_skill, enemy) then
					use.card = card
					if use.to then
						sgs.ai_skill_cardchosen[name] = self:getCardRandomly(enemy, "he")
						use.to:append(enemy)
						self:speak("hostile")
					end
					return
				else
					use.card = card
					if use.to then
						if not equips:isEmpty() then
							sgs.ai_skill_cardchosen[name] = self:getCardRandomly(enemy, "e")
						else
							sgs.ai_skill_cardchosen[name] = self:getCardRandomly(enemy, "h") end
						use.to:append(enemy)
						self:speak("hostile")
					end
					return
				end
			end
		end
	end
end

SmartAI.useCardSnatch = SmartAI.useCardSnatchOrDismantlement

sgs.ai_use_value.Snatch = 9
sgs.ai_use_priority.Snatch = 4.3

sgs.dynamic_value.control_card.Snatch = true
function sgs.ai_card_intention.Snatch()
	sgs.ai_snat_disma_effect = false
end

SmartAI.useCardDismantlement = SmartAI.useCardSnatchOrDismantlement

sgs.ai_use_value.Dismantlement = 5.6
sgs.ai_use_priority.Dismantlement = 4.4
function sgs.ai_card_intention.Dismantlement()
	sgs.ai_snat_disma_effect = false
end

sgs.dynamic_value.control_card.Dismantlement = true

function SmartAI:useCardCollateral(card, use)
	self:sort(self.enemies,"threat")

	for _, friend in ipairs(self.friends_noself) do
		if friend:getWeapon() and self:hasSkills(sgs.lose_equip_skill, friend)
			and not self.room:isProhibited(self.player, friend, card) then

			for _, enemy in ipairs(self.enemies) do
				if friend:canSlash(enemy) then
					use.card = card
				end
				if use.to then use.to:append(friend) end
				if use.to then use.to:append(enemy) end
				return
			end
		end
	end

	local n = nil
	local final_enemy = nil
	for _, enemy in ipairs(self.enemies) do
		if not self.room:isProhibited(self.player, enemy, card)
			and self:hasTrickEffective(card, enemy)
			and not self:hasSkills(sgs.lose_equip_skill, enemy)
			and enemy:getWeapon() then

			for _, enemy2 in ipairs(self.enemies) do
				if enemy:canSlash(enemy2, card) then
					if enemy:getHandcardNum() == 0 then
						use.card = card
						if use.to then use.to:append(enemy) end
						if use.to then use.to:append(enemy2) end
						return
					else
						n = 1
						final_enemy = enemy2
					end
				end
			end
			if n then use.card = card end
			if use.to then use.to:append(enemy) end
			if use.to then use.to:append(final_enemy) end
			return

		end
		n = nil
	end
end

sgs.ai_use_value.Collateral = 8.8
sgs.ai_use_priority.Collateral = 2.75

sgs.ai_card_intention.Collateral = function(card, from, tos)
	assert(#tos == 2)
	if tos[2]:objectName() == from:objectName() then
		sgs.updateIntention(from, tos[1], 80)
	elseif sgs.compareRoleEvaluation(tos[1], "rebel", "loyalist") == sgs.compareRoleEvaluation(tos[2], "rebel", "loyalist") then
		sgs.updateIntention(from, tos[2], 80)
	elseif from:getWeapon() and from:distanceTo(tos[2]) <= from:getAttackRange() then
		sgs.updateIntention(from, tos[1], 80)
	elseif tos[1]:isKongcheng() then
		sgs.updateIntention(from, tos[1], 80)
	end
	sgs.ai_collateral = false
end

sgs.dynamic_value.control_card.Collateral = true

sgs.ai_skill_cardask["collateral-slash"] = function(self, data, pattern, target, target2)
	if target and target2 and not self:hasSkills(sgs.lose_equip_skill) and self:isEnemy(target2) then
		for _, slash in ipairs(self:getCards("Slash")) do
			if self:slashIsEffective(slash, target2) then
				return slash:toString()
			end
		end
	end
	if target and target2 and not self:hasSkills(sgs.lose_equip_skill) and self:isFriend(target2) then
		for _, slash in ipairs(self:getCards("Slash")) do
			if not self:slashIsEffective(slash, target2) then
				return slash:toString()
			end
		end
		if (target2:getHp() > 2 or self:getCardsNum("Jink", target2) > 1) and not target2:getRole() == "lord" and self.player:getHandcardNum() > 1 then
			for _, slash in ipairs(self:getCards("Slash")) do
				return slash:toString()
			end
		end
	end
	self:speak("collateral")
	return "."
end

local function hp_subtract_handcard(a,b)
	local diff1 = a:getHp() - a:getHandcardNum()
	local diff2 = b:getHp() - b:getHandcardNum()

	return diff1 < diff2
end

function SmartAI:useCardIndulgence(card, use)
	table.sort(self.enemies, hp_subtract_handcard)

	local enemies = self:exclude(self.enemies, card)
	for _, enemy in ipairs(enemies) do
		if enemy:hasSkill("baoguo") and not enemy:containsTrick("indulgence") and not enemy:isKongcheng() and enemy:faceUp() and self:objectiveLevel(enemy) > 3 then
			use.card = card
			if use.to then use.to:append(enemy) end
			return
		end
	end

	for _, enemy in ipairs(enemies) do
		if not enemy:containsTrick("indulgence") and not enemy:hasSkill("shemi") and enemy:faceUp() and self:objectiveLevel(enemy) > 3 then
			use.card = card
			if use.to then use.to:append(enemy) end
			return
		end
	end
end

sgs.ai_use_value.Indulgence = 8
sgs.ai_use_priority.Indulgence = 8.9
sgs.ai_card_intention.Indulgence = function(card, from, tos, self)
	self:speakTrigger(card,from,tos[1])
	sgs.updateIntentions(from, tos, 120)
end

sgs.dynamic_value.control_usecard.Indulgence = true

function SmartAI:useCardLightning(card, use)
	if self.player:containsTrick("lightning") then return end
	if self.room:isProhibited(self.player, self.player, card) then end
--	if not self:hasWizard(self.enemies) then--and self.room:isProhibited(self.player, self.player, card) then
	local function hasDangerousFriend()
		local hashy = false
		for _, aplayer in ipairs(self.enemies) do
			if aplayer:hasSkill("hongyan") then hashy = true break end
		end
		for _, aplayer in ipairs(self.enemies) do
			if aplayer:hasSkill("guanxing") or (aplayer:hasSkill("gongxin") and hashy)
			or aplayer:hasSkill("xinzhan") then
				if self:isFriend(aplayer:getNextAlive()) then return true end
			end
		end
		return false
	end
	if self:getFinalRetrial(self.player) == 2 then
	return
	elseif self:getFinalRetrial(self.player) == 1 then
		use.card = card
		return
	elseif not hasDangerousFriend() then
		local players = self.room:getAllPlayers()
		players = sgs.QList2Table(players)

		local friends = 0
		local enemies = 0

		for _,player in ipairs(players) do
			if self:objectiveLevel(player) >= 4 then
				enemies = enemies + 1
			elseif self:isFriend(player) then
				friends = friends + 1
			end
		end

		local ratio

		if friends == 0 then ratio = 999
		else ratio = enemies/friends
		end

		if ratio > 1.5 then
			use.card = card
			return
		end
	end
end

sgs.dynamic_value.lucky_chance.Lightning = true

sgs.ai_keep_value.Lightning = -1
