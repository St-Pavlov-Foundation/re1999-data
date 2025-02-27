module("modules.logic.versionactivity2_6.xugouji.rpc.Activity188Rpc", package.seeall)

slot0 = class("Activity188Rpc", BaseRpc)

function slot0.sendGet188InfosRequest(slot0, slot1, slot2, slot3)
	slot4 = Activity188Module_pb.GetAct188InfoRequest()
	slot4.activityId = slot1

	slot0:sendMsg(slot4, slot2, slot3)
end

function slot0.onReceiveGetAct188InfoReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity188Model.instance:onGetActInfoReply(slot2.episodes)
	end
end

function slot0.sendAct188EnterEpisodeRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity188Module_pb.Act188EnterEpisodeRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct188EnterEpisodeReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity188Model.instance:clearGameInfo()
		Activity188Model.instance:setTurn(true)
		Activity188Model.instance:setCurEpisodeId(slot2.episodeId)
		Activity188Model.instance:onAct188GameInfoUpdate(slot2.act188Game)
	end
end

function slot0.SetEpisodePushCallback(slot0, slot1, slot2)
	slot0._episodePushCb = slot1
	slot0._episodePushCbObj = slot2
end

function slot0.onReceiveAct188EpisodePush(slot0, slot1, slot2)
	if slot1 == 0 then
		for slot7, slot8 in ipairs(slot2.episodes) do
			Activity188Model.instance:onEpisodeInfoUpdate(slot8.episodeId, slot8.isFinished)
		end

		if slot0._episodePushCb then
			slot0._episodePushCb(slot0._episodePushCbObj)
		end
	end
end

function slot0.sendAct188StoryRequest(slot0, slot1, slot2, slot3, slot4)
	slot5 = Activity188Module_pb.Act188StoryRequest()
	slot5.activityId = slot1
	slot5.episodeId = slot2

	slot0:sendMsg(slot5, slot3, slot4)
end

function slot0.onReceiveAct188StoryReply(slot0, slot1, slot2)
	if slot1 == 0 then
		Activity188Model.instance:onStoryEpisodeFinish(slot2.episodeId)
	end
end

function slot0.sendAct188ReverseCardRequest(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = Activity188Module_pb.Act188ReverseCardRequest()
	slot6.activityId = slot1
	slot6.episodeId = slot2
	slot6.uid = slot3

	slot0:sendMsg(slot6, slot4, slot5)
end

function slot0.onReceiveAct188ReverseCardReply(slot0, slot1, slot2)
	if slot1 == 0 then
		-- Nothing
	end
end

function slot0.onReceiveAct188StepPush(slot0, slot1, slot2)
	if slot1 == 0 then
		XugoujiGameStepController.instance:insertStepList(slot2.steps)
	end
end

slot0.instance = slot0.New()

return slot0
