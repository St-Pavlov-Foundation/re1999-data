module("modules.logic.tower.model.TowerAssistBossModel", package.seeall)

slot0 = class("TowerAssistBossModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.tempBossDict = {}
end

function slot0.updateAssistBossInfo(slot0, slot1)
	if not slot0:getById(slot1.id) then
		slot3 = TowerAssistBossMo.New()

		slot3:init(slot2)
		slot0:addAtLast(slot3)
	end

	slot3:setTempState(false)
	slot3:updateInfo(slot1)
end

function slot0.onTowerActiveTalent(slot0, slot1)
	if slot0:getById(slot1.bossId) then
		slot3:onTowerActiveTalent(slot1)
	end
end

function slot0.onTowerResetTalent(slot0, slot1)
	if slot0:getById(slot1.bossId) then
		slot3:onTowerResetTalent(slot1)
	end
end

function slot0.getBoss(slot0, slot1)
	if not (slot0:getById(slot1) or slot0.tempBossDict[slot1]) then
		slot2 = TowerAssistBossMo.New()

		slot2:init(slot1)
		slot2:initTalentIds()

		slot0.tempBossDict[slot1] = slot2
	end

	return slot2
end

function slot0.onTowerRenameTalentPlan(slot0, slot1)
	if slot0:getById(slot1.bossId) then
		slot3:renameTalentPlan(slot1.planName)
	end
end

function slot0.cleanTrialLevel(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		slot6:setTrialInfo(0, slot6.useTalentPlan)
	end
end

function slot0.getLimitedTrialBossSaveKey(slot0, slot1)
	return "TowerLimitedTrialBoss" .. TowerTimeLimitLevelModel.instance:getCurOpenTimeLimitTower().towerId .. "_" .. slot1.id
end

function slot0.setLimitedTrialBossInfo(slot0, slot1)
	slot1:setTrialInfo(tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel)), slot0:getLimitedTrialBossLocalPlan(slot1))
	slot1:refreshTalent()
end

function slot0.getLimitedTrialBossLocalPlan(slot0, slot1)
	return TowerController.instance:getPlayerPrefs(slot0:getLimitedTrialBossSaveKey(slot1), TowerConfig.instance:getAllTalentPlanConfig(slot1.id)[1].planId)
end

function slot0.getLimitedTrialBossTalentPlan(slot0, slot1)
	slot2 = 0
	slot5 = slot0:getBoss(HeroGroupModel.instance:getCurGroupMO() and slot3:getAssistBossId() or FightModel.instance.last_fightGroup.assistBossId)

	if slot1.towerType == TowerEnum.TowerType.Limited then
		return slot5 and slot5.trialTalentPlan > 0 and slot5.level < tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel)) and slot5.trialTalentPlan or 0
	else
		return slot5 and slot5.useTalentPlan or 0
	end

	return slot2
end

function slot0.getTempUnlockTrialBossMO(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	if not slot0:getById(slot1) then
		slot2 = slot0:buildTempUnlockTrialBossMO(slot1)

		slot0:addAtLast(slot2)

		return slot2
	elseif slot2 and slot2:getTempState() then
		return slot0:buildTempUnlockTrialBossMO(slot1, slot2)
	end
end

function slot0.buildTempUnlockTrialBossMO(slot0, slot1, slot2)
	slot3 = slot2 or TowerAssistBossMo.New()

	slot3:init(slot1)
	slot3:setTempState(true)
	slot3:setTrialInfo(tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel)), slot0:getLimitedTrialBossLocalPlan({
		id = slot1
	}))
	slot3:refreshTalent()

	return slot3
end

function slot0.sortBossList(slot0, slot1)
	if slot0.towerStartTime ~= slot1.towerStartTime then
		return slot1.towerStartTime < slot0.towerStartTime
	else
		return slot0.towerId < slot1.towerId
	end
end

slot0.instance = slot0.New()

return slot0
