module("modules.logic.versionactivity2_7.coopergarland.model.CooperGarlandModel", package.seeall)

slot0 = class("CooperGarlandModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clearData()
end

function slot0.reInit(slot0)
	slot0:clearData()
end

function slot0.clearData(slot0)
	slot0._actInfoDic = {}
	slot0._actNewestEpisodeDict = {}
end

function slot0.updateAct192Info(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = slot1.activityId

	if slot1.episodes then
		for slot7, slot8 in ipairs(slot3) do
			slot0:updateAct192Episode(slot2, slot8.episodeId, slot8.isFinished, slot8.progress)
		end
	end

	slot0:updateNewestEpisode(slot2)
end

function slot0.updateAct192Episode(slot0, slot1, slot2, slot3, slot4)
	if not slot1 or not slot2 then
		return
	end

	if not slot0._actInfoDic[slot1] then
		slot0._actInfoDic[slot1] = {}
	end

	if not slot5[slot2] then
		slot5[slot2] = {}
	end

	slot6.isFinished = slot3
	slot6.progress = slot4
end

function slot0.updateNewestEpisode(slot0, slot1)
	slot2 = nil

	for slot7, slot8 in ipairs(CooperGarlandConfig.instance:getEpisodeIdList(slot1, true)) do
		if slot0:isUnlockEpisode(slot1, slot8) and not slot0:isFinishedEpisode(slot1, slot8) then
			slot2 = slot8
		end
	end

	slot0._actNewestEpisodeDict[slot1] = slot2
end

function slot0.getAct192Id(slot0)
	return VersionActivity2_7Enum.ActivityId.CooperGarland
end

function slot0.isAct192Open(slot0, slot1)
	slot3, slot4, slot5 = nil

	if ActivityModel.instance:getActivityInfo()[slot0:getAct192Id()] then
		slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(slot2)
	else
		slot4 = ToastEnum.ActivityEnd
	end

	if slot1 and slot4 then
		GameFacade.showToast(slot4, slot5)
	end

	return slot3 == ActivityEnum.ActivityStatus.Normal
end

function slot0.getAct192RemainTimeStr(slot0, slot1)
	slot2 = ""
	slot3 = true

	if ActivityModel.instance:getActivityInfo()[slot1 or slot0:getAct192Id()] and slot5:getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot2 = TimeUtil.SecondToActivityTimeFormat(slot6)
		slot3 = false
	end

	return slot2, slot3
end

function slot0.getEpisodeInfo(slot0, slot1, slot2)
	slot3 = nil

	if slot1 and slot2 and slot0._actInfoDic and slot0._actInfoDic[slot1] then
		slot3 = slot4[slot2]
	end

	return slot3
end

function slot0.isUnlockEpisode(slot0, slot1, slot2)
	return slot0:getEpisodeInfo(slot1, slot2) ~= nil
end

function slot0.isFinishedEpisode(slot0, slot1, slot2)
	return slot0:getEpisodeInfo(slot1, slot2) and slot3.isFinished
end

function slot0.getEpisodeProgress(slot0, slot1, slot2)
	if string.nilorempty(slot0:getEpisodeInfo(slot1, slot2) and slot3.progress) then
		slot4 = CooperGarlandEnum.Const.DefaultGameProgress
	end

	return tonumber(slot4)
end

function slot0.getNewestEpisodeId(slot0, slot1)
	return slot0._actNewestEpisodeDict and slot0._actNewestEpisodeDict[slot1]
end

function slot0.isNewestEpisode(slot0, slot1, slot2)
	slot3 = false

	if slot1 and slot2 then
		slot3 = slot2 == slot0:getNewestEpisodeId(slot1)
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
