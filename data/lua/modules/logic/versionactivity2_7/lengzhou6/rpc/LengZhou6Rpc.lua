module("modules.logic.versionactivity2_7.lengzhou6.rpc.LengZhou6Rpc", package.seeall)

slot0 = class("LengZhou6Rpc", BaseRpc)

function slot0.sendGetAct190InfoRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity190Module_pb.GetAct190InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct190InfoReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	LengZhou6Model.instance:onGetActInfo(slot2)
	LengZhou6Controller.instance:openLengZhou6LevelView()
end

function slot0.sendAct190FinishEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity190Module_pb.Act190FinishEpisodeRequest()
	slot5.activityId = LengZhou6Model.instance:getCurActId()
	slot5.episodeId = slot1
	slot5.progress = slot2 or ""

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct190FinishEpisodeReply(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	LengZhou6Controller.instance:onFinishEpisode(slot2)
end

function slot0.onReceiveAct190EpisodePush(slot0, slot1, slot2)
	if slot1 ~= 0 then
		return
	end

	LengZhou6Model.instance:onPushActInfo(slot2)
end

slot0.instance = slot0.New()

return slot0
