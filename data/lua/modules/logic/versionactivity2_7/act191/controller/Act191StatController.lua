module("modules.logic.versionactivity2_7.act191.controller.Act191StatController", package.seeall)

slot0 = class("Act191StatController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.viewOpenTimeMap = {}
end

function slot0.setActInfo(slot0, slot1, slot2)
	slot0.actId = slot1
	slot0.actInfo = slot2
end

function slot0.onViewOpen(slot0, slot1)
	if not slot0.viewOpenTimeMap[slot1] then
		slot0.viewOpenTimeMap[slot1] = ServerTime.now()
	end
end

function slot0.statViewClose(slot0, slot1, slot2, slot3)
	if not slot0.viewOpenTimeMap[slot1] then
		return
	end

	slot3 = slot3 or ""
	slot4 = ServerTime.now() - slot0.viewOpenTimeMap[slot1]
	slot5 = slot0.actInfo:getGameInfo()
	slot6 = {
		coin = slot5.coin,
		stage = slot5.curStage,
		node = slot5.curNode,
		score = slot5.score,
		rank = slot5.rank
	}
	slot8 = {}

	if slot5:getNodeDetailMo(nil, true) then
		slot8 = {
			shopId = slot7.shopId,
			eventId = slot7.eventId,
			type = slot7.type
		}
	end

	StatController.instance:track(StatEnum.EventName.Act191CloseView, {
		[StatEnum.EventProperties.Act191BaseInfo] = slot6,
		[StatEnum.EventProperties.Act191NodeInfo] = slot8,
		[StatEnum.EventProperties.ViewName] = slot1,
		[StatEnum.EventProperties.UseTime] = slot4,
		[StatEnum.EventProperties.CooperGarland_From] = slot2 and "Manual" or "Auto",
		[StatEnum.EventProperties.ProductName] = slot3
	})

	slot0.viewOpenTimeMap[slot1] = nil
end

function slot0.statButtonClick(slot0, slot1, slot2)
	slot3 = slot0.actInfo:getGameInfo()
	slot4 = {
		coin = slot3.coin,
		stage = slot3.curStage,
		node = slot3.curNode,
		score = slot3.score,
		rank = slot3.rank
	}
	slot6 = {}

	if slot3:getNodeDetailMo(nil, true) then
		slot6 = {
			shopId = slot5.shopId,
			eventId = slot5.eventId,
			type = slot5.type
		}
	end

	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.Act191BaseInfo] = slot4,
		[StatEnum.EventProperties.Act191NodeInfo] = slot6,
		[StatEnum.EventProperties.ViewName] = slot1,
		[StatEnum.EventProperties.ButtonName] = slot2
	})
end

slot0.instance = slot0.New()

return slot0
