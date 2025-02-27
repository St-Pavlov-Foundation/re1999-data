module("modules.logic.weekwalk_2.model.WeekWalk_2Model", package.seeall)

slot0 = class("WeekWalk_2Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
	slot0._weekWalkInfo = nil
	slot0._weekWalkSettleInfo = nil
	slot0._isWin = nil
end

function slot0.initFightSettleInfo(slot0, slot1, slot2)
	slot0._isWin = slot1 == 1
	slot0._resultCupInfos = GameUtil.rpcInfosToMap(slot2, WeekwalkVer2CupInfoMO, "index")
end

function slot0.isWin(slot0)
	return slot0._isWin
end

function slot0.getResultCupInfos(slot0)
	return slot0._resultCupInfos
end

function slot0.initSettleInfo(slot0, slot1)
	slot2 = WeekwalkVer2SettleInfoMO.New()

	slot2:init(slot1)

	slot0._weekWalkSettleInfo = slot2
end

function slot0.getSettleInfo(slot0)
	return slot0._weekWalkSettleInfo
end

function slot0.clearSettleInfo(slot0)
	slot0._weekWalkSettleInfo = nil
end

function slot0.updateInfo(slot0, slot1)
	slot0:initInfo(slot1)
end

function slot0.initInfo(slot0, slot1)
	callWithCatch(function ()
		uv0:init(uv1)
	end)

	slot0._weekWalkInfo = WeekwalkVer2InfoMO.New()
end

function slot0.getInfo(slot0)
	return slot0._weekWalkInfo
end

function slot0.getTimeId(slot0)
	return slot0._weekWalkInfo and slot0._weekWalkInfo.timeId
end

function slot0.getLayerInfo(slot0, slot1)
	return slot0._weekWalkInfo and slot0._weekWalkInfo:getLayerInfo(slot1)
end

function slot0.getLayerInfoByLayerIndex(slot0, slot1)
	return slot0._weekWalkInfo and slot0._weekWalkInfo:getLayerInfoByLayerIndex(slot1)
end

function slot0.setBattleElementId(slot0, slot1)
	slot0._battleElementId = slot1
end

function slot0.getBattleElementId(slot0)
	return slot0._battleElementId
end

function slot0.setCurMapId(slot0, slot1)
	slot0._curMapId = slot1
end

function slot0.getCurMapId(slot0)
	return slot0._curMapId
end

function slot0.getCurMapInfo(slot0)
	return slot0:getLayerInfo(slot0._curMapId)
end

function slot0.getBattleInfo(slot0, slot1, slot2)
	return slot0:getLayerInfo(slot1) and slot3:getBattleInfoByBattleId(slot2)
end

function slot0.getBattleInfoByLayerAndIndex(slot0, slot1, slot2)
	slot3 = slot0._weekWalkInfo and slot0._weekWalkInfo:getLayerInfoByLayerIndex(slot1)

	return slot3 and slot3:getBattleInfoByIndex(slot2)
end

function slot0.getBattleInfoByIdAndIndex(slot0, slot1, slot2)
	slot3 = slot0._weekWalkInfo and slot0._weekWalkInfo:getLayerInfo(slot1)

	return slot3 and slot3:getBattleInfoByIndex(slot2)
end

function slot0.getCurMapHeroCd(slot0, slot1)
	return slot0:getHeroCd(slot0._curMapId, slot1)
end

function slot0.getHeroCd(slot0, slot1, slot2)
	return slot0:getLayerInfo(slot1) and slot3:heroInCD(slot2) and 1 or 0
end

function slot0.getFightParam(slot0)
	if WeekWalk_2BuffListModel.getCurHeroGroupSkillId() then
		-- Nothing
	end

	return cjson.encode({
		elementId = slot0:getBattleElementId(),
		layerId = slot0:getCurMapId(),
		chooseSkillIds = {
			slot4
		}
	})
end

function slot0.setFinishMapId(slot0, slot1)
	slot0._curFinishMapId = slot1
end

function slot0.getFinishMapId(slot0)
	return slot0._curFinishMapId
end

slot0.instance = slot0.New()

return slot0
