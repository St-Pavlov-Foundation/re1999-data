module("modules.logic.fight.system.work.FightWorkRefreshPerformanceEntityData", package.seeall)

slot0 = class("FightWorkRefreshPerformanceEntityData", FightWorkItem)

function slot0.onStart(slot0, slot1)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		slot0:onDone(true)

		return
	end

	if FightModel.instance:isFinish() then
		slot0:onDone(true)

		return
	end

	if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
		slot0:onDone(true)

		return
	end

	if FightReplayModel.instance:isReplay() then
		if FightModel.instance:getVersion() >= 4 then
			slot0:_refreshPerformanceData()
		end

		slot0:onDone(true)

		return
	end

	slot0:_refreshPerformanceData(true)
	slot0:onDone(true)
end

function slot0._refreshPerformanceData(slot0)
	for slot7, slot8 in pairs(FightLocalDataMgr.instance.entityMgr:getAllEntityMO()) do
		if not slot8:isStatusDead() then
			slot11, slot12 = FightDataUtil.findDiff(slot8, FightDataHelper.entityMgr:getById(slot8.id), {
				buffFeaturesSplit = true,
				playCardExPoint = true,
				resistanceDict = true,
				_playCardAddExpoint = true,
				configMaxExPoint = true,
				moveCardExPoint = true,
				passiveSkillDic = true,
				_combineCardAddExpoint = true,
				custom_refreshNameUIOp = true,
				class = true,
				skillList = true,
				_moveCardAddExpoint = true
			}, {
				attrMO = FightWorkCompareServerEntityData.compareAttrMO,
				summonedInfo = FightWorkCompareServerEntityData.compareSummonedInfo
			})

			if slot11 then
				FightEntityDataHelper.copyEntityMO(slot8, slot10)
				FightController.instance:dispatchEvent(FightEvent.CoverPerformanceEntityData, slot9)
			end
		end
	end
end

function slot0.clearWork(slot0)
end

return slot0
