module("modules.logic.rouge.controller.RougeOutsideController", package.seeall)

slot0 = class("RougeOutsideController", BaseController)

function slot0.onInit(slot0)
	slot0._model = RougeOutsideModel.instance
end

function slot0.addConstEvents(slot0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, slot0._onGetOpenInfoSuccess, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, slot0._updateRelateDotInfo, slot0)
end

function slot0.reInit(slot0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._updateRelateDotInfo, slot0)
end

function slot0._onGetOpenInfoSuccess(slot0)
	if OpenModel.instance:isFunctionUnlock(slot0._model:config():openUnlockId()) then
		return
	end

	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._onNewFuncUnlock, slot0)
end

function slot0._updateRelateDotInfo(slot0, slot1)
	if not slot0:isOpen() or not slot1 or not slot1[RedDotEnum.DotNode.RougeDLCNew] then
		return
	end

	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, slot0._updateRelateDotInfo, slot0)
	slot0:initDLCReddotInfo()
end

function slot0._onDailyRefresh(slot0)
	if not slot0:isOpen() then
		return
	end

	slot0:sendRpcToGetOutsideInfo()
end

function slot0.sendRpcToGetOutsideInfo(slot0)
	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(slot0._model:season())
end

function slot0.checkOutSideStageInfo(slot0)
end

function slot0._onNewFuncUnlock(slot0, slot1)
	slot4 = false

	for slot8, slot9 in ipairs(slot1) do
		if slot9 == slot0._model:config():openUnlockId() then
			slot4 = true

			break
		end
	end

	if not slot4 then
		return
	end

	slot0._model:setIsNewUnlockDifficulty(1, true)
	slot0:sendRpcToGetOutsideInfo()
	slot0:initDLCReddotInfo()
end

function slot0.isOpen(slot0)
	return slot0._model:isUnlock()
end

function slot0.initDLCReddotInfo(slot0)
	slot1 = slot0:_createDLCReddotInfo(RougeDLCEnum.DLCEnum.DLC_103)

	RedDotRpc.instance:clientAddRedDotGroupList({
		slot1,
		slot0:_createDLCEntryReddotInfo({
			slot1
		})
	}, true)
end

function slot0._createDLCReddotInfo(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	return {
		id = RedDotEnum.DotNode.RougeDLCNew,
		uid = slot1,
		value = slot0:checkIsDLCNotRead(slot1) and 1 or 0
	}
end

function slot0.checkIsDLCNotRead(slot0, slot1)
	return string.nilorempty(PlayerPrefsHelper.getString(slot0:_generateNewReadDLCInLocalKey(slot1), ""))
end

function slot0._createDLCEntryReddotInfo(slot0, slot1)
	slot2 = {
		uid = 0,
		value = 0,
		id = RedDotEnum.DotNode.RougeDLCNew
	}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if slot7.value and slot7.value > 0 then
				slot2.value = 1

				break
			end
		end
	end

	return slot2
end

function slot0.saveNewReadDLCInLocal(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return
	end

	PlayerPrefsHelper.setString(slot0:_generateNewReadDLCInLocalKey(slot1), "true")
end

function slot0._generateNewReadDLCInLocalKey(slot0, slot1)
	return string.format("%s#%s#%s", PlayerPrefsKey.RougeHasReadDLCId, PlayerModel.instance:getMyUserId(), slot1)
end

slot0.instance = slot0.New()

return slot0
