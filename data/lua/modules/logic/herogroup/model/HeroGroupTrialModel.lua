module("modules.logic.herogroup.model.HeroGroupTrialModel", package.seeall)

slot0 = class("HeroGroupTrialModel", BaseModel)

function slot0.ctor(slot0)
	slot0.curBattleId = nil
	slot0._limitNum = 0
	slot0._trialEquipMo = BaseModel.New()

	uv0.super.ctor(slot0)
end

function slot0.setTrialByBattleId(slot0, slot1)
	if slot0.curBattleId == (slot1 or HeroGroupModel.instance.battleId) then
		return
	end

	slot0.curBattleId = slot1

	if not lua_battle.configDict[slot1] then
		return
	end

	slot0._trialEquipMo:clear()
	uv0.super.clear(slot0)

	slot3 = slot2.trialHeros

	if HeroGroupModel.instance.episodeId and slot1 == HeroGroupModel.instance.battleId then
		slot3 = HeroGroupHandler.getTrialHeros(HeroGroupModel.instance.episodeId)
	end

	if not string.nilorempty(slot3) then
		for slot8, slot9 in pairs(GameUtil.splitString2(slot3, true)) do
			slot10 = slot9[1]

			if lua_hero_trial.configDict[slot10] and lua_hero_trial.configDict[slot10][slot9[2] or 0] then
				slot13 = HeroMo.New()

				slot13:initFromTrial(unpack(slot9))
				slot0:addAtLast(slot13)
			else
				logError(string.format("试用角色配置不存在:%s#%s", slot10, slot11))
			end
		end
	end

	if not string.nilorempty(slot2.trialEquips) then
		for slot8, slot9 in pairs(string.splitToNumber(slot2.trialEquips, "|")) do
			if lua_equip_trial.configDict[slot9] then
				slot11 = EquipMO.New()

				slot11:initByTrialEquipCO(slot10)
				slot0._trialEquipMo:addAtLast(slot11)
			else
				logError("试用心相配置不存在" .. tostring(slot9))
			end
		end
	end

	slot0._limitNum = slot2.trialLimit

	if ToughBattleModel.instance:getAddTrialHeros() then
		slot8 = slot0._limitNum
		slot0._limitNum = math.min(4, #slot4 + slot8)

		for slot8, slot9 in pairs(slot4) do
			slot10 = HeroMo.New()

			slot10:initFromTrial(slot9)
			slot0:addAtLast(slot10)
		end
	end
end

slot1 = false
slot2 = false

function slot0.sortByLevelAndRare(slot0, slot1, slot2)
	uv0 = slot1
	uv1 = slot2

	slot0:sort(uv2.sortMoFunc)
end

function slot0.sortMoFunc(slot0, slot1)
	if uv0 then
		if slot0.level ~= slot1.level then
			if uv1 then
				return slot0.level < slot1.level
			else
				return slot1.level < slot0.level
			end
		elseif slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		end
	elseif slot0.config.rare ~= slot1.config.rare then
		if uv1 then
			return slot0.config.rare < slot1.config.rare
		else
			return slot1.config.rare < slot0.config.rare
		end
	elseif slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	end

	return slot0.config.id < slot1.config.id
end

function slot0.setFilter(slot0, slot1, slot2)
	slot0._filterDmgs = slot1
	slot0._filterCareers = slot2
end

function slot0.getFilterList(slot0)
	slot0:checkBattleIdIsVaild()

	slot1 = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		if (not slot0._filterCareers or tabletool.indexOf(slot0._filterCareers, slot6.config.career)) and (not slot0._filterDmgs or tabletool.indexOf(slot0._filterDmgs, slot6.config.dmgType)) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.clear(slot0)
	slot0.curBattleId = nil
	slot0._limitNum = 0

	slot0._trialEquipMo:clear()
	uv0.super.clear(slot0)
end

function slot0.getLimitNum(slot0)
	slot0:checkBattleIdIsVaild()

	return slot0._limitNum
end

function slot0.getHeroMo(slot0, slot1)
	return slot0:getById(tostring(tonumber(slot1.id .. "." .. slot1.trialTemplate) - 1099511627776.0))
end

function slot0.getEquipMo(slot0, slot1)
	return slot0._trialEquipMo:getById(tonumber(slot1))
end

function slot0.getTrialEquipList(slot0)
	return slot0._trialEquipMo:getList()
end

function slot0.checkBattleIdIsVaild(slot0)
	if slot0.curBattleId and HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 and slot0.curBattleId ~= HeroGroupModel.instance.battleId then
		slot0:clear()
	end
end

function slot0.isOnlyUseTrial(slot0)
	slot0:checkBattleIdIsVaild()

	if not slot0.curBattleId then
		return false
	end

	return slot0._limitNum > 0 and lua_battle.configDict[slot0.curBattleId].onlyTrial == 1
end

function slot0.haveTrialEquip(slot0)
	slot0:checkBattleIdIsVaild()

	return slot0._trialEquipMo:getCount() > 0
end

slot0.instance = slot0.New()

return slot0
