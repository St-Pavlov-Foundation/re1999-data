module("modules.logic.versionactivity2_7.coopergarland.rpc.Activity192Rpc", package.seeall)

slot0 = class("Activity192Rpc", BaseRpc)

function slot0.sendGetAct192InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity192Module_pb.GetAct192InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct192InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CooperGarlandController.instance:onGetAct192Info(slot2)
end

function slot0.sendAct192FinishEpisodeRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity192Module_pb.Act192FinishEpisodeRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.progress = slot3 or CooperGarlandConfig.instance:isGameEpisode(slot1, slot2) and CooperGarlandEnum.Const.DefaultGameProgress or ""

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct192FinishEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end
end

function slot0.onReceiveAct192EpisodePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	CooperGarlandController.instance:onGetAct192Info(slot2)
end

slot0.instance = slot0.New()

return slot0
