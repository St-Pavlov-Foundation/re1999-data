module("modules.logic.versionactivity2_7.act191.rpc.Activity191Rpc", package.seeall)

slot0 = class("Activity191Rpc", BaseRpc)

function slot0.sendGetAct191InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.GetAct191InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct191InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:setActInfo(slot2.activityId, slot2.info)
end

function slot0.sendStart191GameRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.Start191GameRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveStart191GameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.sendSelect191InitBuildRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity191Module_pb.Select191InitBuildRequest()
	slot5.activityId = slot1
	slot5.initBuildId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSelect191InitBuildReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot5 = Activity191Model.instance:getActInfo(slot2.activityId)

	slot5:updateGameInfo(slot2.gameInfo)
	slot5:getGameInfo():autoFill()
end

function slot0.sendSelect191NodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity191Module_pb.Select191NodeRequest()
	slot5.activityId = slot1
	slot5.index = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSelect191NodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.sendFresh191ShopRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.Fresh191ShopRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveFresh191ShopReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot6 = Activity191Model.instance:getActInfo(slot2.activityId):getGameInfo()
	slot6.coin = slot2.coin

	slot6:updateCurNodeInfo(slot2.nodeInfo)
end

function slot0.sendBuyIn191ShopRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity191Module_pb.BuyIn191ShopRequest()
	slot5.activityId = slot1
	slot5.index = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveBuyIn191ShopReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.sendLeave191ShopRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.Leave191ShopRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveLeave191ShopReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.sendSelect191EnhanceRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity191Module_pb.Select191EnhanceRequest()
	slot5.activityId = slot1
	slot5.index = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveSelect191EnhanceReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.sendFresh191EnhanceRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity191Module_pb.Fresh191EnhanceRequest()
	slot5.activityId = slot1
	slot5.index = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveFresh191EnhanceReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):getGameInfo():updateCurNodeInfo(slot2.nodeInfo)
end

function slot0.sendGain191RewardEventRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.Gain191RewardEventRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGain191RewardEventReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.sendChangeAct191TeamRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.ChangeAct191TeamRequest()
	slot4.activityId = slot1
	slot4.curTeamIndex = slot2
	slot4.teamInfo.index = slot3.index
	slot4.teamInfo.name = slot3.name

	for slot8, slot9 in ipairs(slot3.battleHeroInfo) do
		if slot9.heroId ~= 0 or slot9.itemUid1 ~= 0 then
			table.insert(slot4.teamInfo.battleHeroInfo, slot9)
		end
	end

	for slot8, slot9 in ipairs(slot3.subHeroInfo) do
		if slot9.heroId ~= 0 then
			table.insert(slot4.teamInfo.subHeroInfo, slot9)
		end
	end

	slot4.teamInfo.auto = slot3.auto

	slot0:sendMsg(slot4)
end

function slot0.onReceiveChangeAct191TeamReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot7 = Activity191Model.instance:getActInfo(slot2.activityId):getGameInfo()
	slot7.rank = slot2.rank

	slot7:updateTeamInfo(slot2.curTeamIndex, slot2.teamInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateTeamInfo)
end

function slot0.sendEndAct191GameRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity191Module_pb.EndAct191GameRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveEndAct191GameReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot5 = Activity191Model.instance:getActInfo(slot2.activityId)
	slot5:getGameInfo().state = Activity191Enum.GameState.None

	slot5:setEnfInfo(slot2.gameEndInfo)
	Activity191Controller.instance:dispatchEvent(Activity191Event.EndGame)
end

function slot0.onReceiveAct191GameInfoUpdatePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):updateGameInfo(slot2.gameInfo)
end

function slot0.onReceiveAct191TriggerEffectPush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	Activity191Model.instance:getActInfo(slot2.activityId):triggerEffectPush(slot2)
end

slot0.instance = slot0.New()

return slot0
