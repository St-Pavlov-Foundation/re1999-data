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

function slot0.sendChangeAct191TeamRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity191Module_pb.ChangeAct191TeamRequest()
	slot5.activityId = slot1
	slot5.curTeamIndex = slot2
	slot5.teamInfo.index = slot3.index
	slot5.teamInfo.name = slot3.name

	for slot9, slot10 in ipairs(slot3.battleHeroInfo) do
		if slot10.heroId ~= 0 or slot10.itemUid1 ~= 0 or slot10.itemUid2 ~= 0 then
			table.insert(slot5.teamInfo.battleHeroInfo, slot10)
		end
	end

	for slot9, slot10 in ipairs(slot3.subHeroInfo) do
		if slot10.heroId ~= 0 then
			table.insert(slot5.teamInfo.subHeroInfo, slot10)
		end
	end

	slot5.teamInfo.auto = slot3.auto
	slot5.opType = slot4 or Activity191Enum.OpTeamType.Normal

	slot0:sendMsg(slot5)
end

function slot0.onReceiveChangeAct191TeamReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	slot8 = Activity191Model.instance:getActInfo(slot2.activityId):getGameInfo()
	slot8.rank = slot2.rank

	slot8:updateTeamInfo(slot2.curTeamIndex, slot2.teamInfo)

	if slot2.opType == Activity191Enum.OpTeamType.Normal then
		Activity191Controller.instance:dispatchEvent(Activity191Event.UpdateTeamInfo)
	elseif slot7 == Activity191Enum.OpTeamType.ChangeName then
		Activity191Controller.instance:dispatchEvent(Activity191Event.ModifyTeamName)
	else
		Activity191Controller.instance:dispatchEvent(Activity191Event.SwitchCurTeam)
	end
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

	Activity191Model.instance:getActInfo(slot2.activityId):triggerEffectPush(slot2.effectId)
end

slot0.instance = slot0.New()

return slot0
