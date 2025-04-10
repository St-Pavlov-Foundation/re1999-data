module("modules.logic.tower.model.TowerAssistBossMo", package.seeall)

slot0 = pureTable("TowerAssistBossMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.level = 0
	slot0.talentPoint = 0
	slot0.useTalentPlan = 1
	slot0.customPlanCount = 1
	slot0.trialLevel = 0
	slot0.trialTalentPlan = 0
	slot0.isTemp = false
end

function slot0.setTrialInfo(slot0, slot1, slot2)
	slot0.trialLevel = slot1
	slot0.trialTalentPlan = slot2
end

function slot0.onTowerActiveTalent(slot0, slot1)
	slot0:addTalentId(slot1.talentId)

	slot0.talentPoint = slot1.talentPoint
	slot0.talentPlanDict[slot0.useTalentPlan].talentPoint = slot0.talentPoint
end

function slot0.onTowerResetTalent(slot0, slot1)
	slot0.talentPoint = slot1.talentPoint

	if slot1.talentId == 0 then
		slot0:initTalentIds()

		slot0.talentPlanDict[slot0.useTalentPlan].talentIds = slot0.talentIdList
		slot0.talentPlanDict[slot0.useTalentPlan].talentPoint = slot0.talentPoint
	else
		slot0:removeTalentId(slot1.talentId)
	end
end

function slot0.updateInfo(slot0, slot1)
	slot0.level = slot1.level
	slot0.useTalentPlan = slot1.useTalentPlan or 1

	slot0:initTalentPlanInfos(slot1.talentPlans)
	slot0:refreshTalent()
end

function slot0.refreshTalent(slot0)
	slot0:initCurTalentInfo()
	slot0:initTalentIds(slot0.talentIds)
end

function slot0.initCurTalentInfo(slot0)
	slot0.customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

	if (slot0.trialTalentPlan > 0 and slot0.trialTalentPlan or slot0.useTalentPlan) <= slot0.customPlanCount then
		slot0.talentIds = slot0.talentPlanDict and slot0.talentPlanDict[slot1].talentIds or {}
		slot0.talentPoint = slot0.talentPlanDict and slot0.talentPlanDict[slot1].talentPoint or 0
	else
		slot0.talentIds = TowerConfig.instance:getTalentPlanNodeIds(slot0.id, slot0.trialTalentPlan > 0 and slot0.trialTalentPlan or slot0.useTalentPlan, slot0.trialLevel > 0 and slot0.trialLevel or slot0.level)

		slot0:initTalentIds(slot0.talentIds)

		slot0.talentPoint = TowerConfig.instance:getAllTalentPoint(slot0.id, slot0.trialLevel > 0 and slot0.trialLevel or slot0.level) - slot0:getCurCostTalentPoint()
	end
end

function slot0.initTalentIds(slot0, slot1)
	slot0.talentIdDict = {}
	slot0.talentIdList = {}
	slot0.talentIdCount = 0

	if slot1 then
		for slot5 = 1, #slot1 do
			slot0:addTalentId(slot1[slot5])
		end
	end
end

function slot0.addTalentId(slot0, slot1)
	if not slot1 or slot0:isActiveTalent(slot1) then
		return
	end

	slot0.talentIdCount = slot0.talentIdCount + 1
	slot0.talentIdDict[slot1] = 1
	slot0.talentIdList[slot0.talentIdCount] = slot1

	if slot0.talentPlanDict and slot0.useTalentPlan <= slot0.customPlanCount then
		slot0.talentPlanDict[slot0.useTalentPlan].talentIds = slot0.talentIdList
	end
end

function slot0.removeTalentId(slot0, slot1)
	if not slot1 or not slot0:isActiveTalent(slot1) then
		return
	end

	slot0.talentIdCount = slot0.talentIdCount - 1
	slot0.talentIdDict[slot1] = nil

	tabletool.removeValue(slot0.talentIdList, slot1)

	if slot0.useTalentPlan <= slot0.customPlanCount then
		slot0.talentPlanDict[slot0.useTalentPlan].talentIds = slot0.talentIdList
	end
end

function slot0.isActiveTalent(slot0, slot1)
	return slot0.talentIdDict[slot1] ~= nil
end

function slot0.getTalentPoint(slot0)
	return slot0.talentPoint
end

function slot0.getTalentTree(slot0)
	if not slot0.talentTree then
		slot0.talentTree = TowerTalentTree.New()

		slot0.talentTree:initTree(slot0, TowerConfig.instance:getAssistTalentConfig().configDict[slot0.id])
	end

	return slot0.talentTree
end

function slot0.getTalentActiveCount(slot0)
	return slot0:getCurCostTalentPoint(), slot0.talentPoint
end

function slot0.getCurCostTalentPoint(slot0)
	for slot5, slot6 in ipairs(slot0.talentIdList) do
		slot1 = 0 + TowerConfig.instance:getAssistTalentConfigById(slot0.id, slot6).consume
	end

	return slot1
end

function slot0.hasTalentCanActive(slot0)
	if slot0.customPlanCount < slot0.useTalentPlan then
		return false
	end

	return slot0:getTalentTree():hasTalentCanActive()
end

function slot0.initTalentPlanInfos(slot0, slot1)
	slot0.talentPlanDict = {}

	for slot6 = 1, TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount) do
		if not slot1[slot6] then
			slot7 = {
				talentIds = {}
			}

			logWarn("boss" .. slot0.id .. "天赋方案数据为空" .. slot6)
		end

		slot8 = {
			planId = slot7.planId or slot6,
			talentPoint = slot7.talentPoint or TowerConfig.instance:getAllTalentPoint(slot0.id, slot0.trialLevel > 0 and slot0.trialLevel or slot0.level),
			planName = string.nilorempty(slot7.planName) and GameUtil.getSubPlaceholderLuaLang(luaLang("towerbosstalentplan"), {
				slot6
			}) or slot7.planName,
			talentIds = {}
		}

		for slot12, slot13 in ipairs(slot7.talentIds) do
			table.insert(slot8.talentIds, slot13)
		end

		slot0.talentPlanDict[slot8.planId] = slot8
	end
end

function slot0.renameTalentPlan(slot0, slot1)
	if slot0.talentPlanDict[slot0.useTalentPlan] then
		slot2.planName = slot1
	end
end

function slot0.getTalentPlanInfos(slot0)
	return slot0.talentPlanDict
end

function slot0.setCurUseTalentPlan(slot0, slot1, slot2)
	if slot2 then
		slot0.trialTalentPlan = slot1
	else
		slot0.useTalentPlan = slot1
		slot0.trialTalentPlan = 0
	end

	slot0:refreshTalent()
end

function slot0.getCurUseTalentPlan(slot0)
	return slot0.useTalentPlan
end

function slot0.setTempState(slot0, slot1)
	slot0.isTemp = slot1
end

function slot0.getTempState(slot0)
	return slot0.isTemp
end

function slot0.isSelectedSystemTalentPlan(slot0)
	slot0.customPlanCount = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.CustomTalentPlanCount))

	return slot0.customPlanCount < (slot0.trialTalentPlan > 0 and slot0.trialTalentPlan or slot0.useTalentPlan)
end

return slot0
