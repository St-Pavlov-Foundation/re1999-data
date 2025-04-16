module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6Model", package.seeall)

slot0 = class("LengZhou6Model", BaseModel)

function slot0.onInit(slot0)
	slot0._actInfoMap = {}
	slot0._actNewestEpisodeDict = {}
end

function slot0.reInit(slot0)
	slot0._actInfoMap = {}
	slot0._actNewestEpisodeDict = {}
end

function slot0.onGetActInfo(slot0, slot1)
	slot0._activityId = slot1.activityId

	if not slot1.episodes or #slot2 <= 0 then
		return
	end

	if slot0._actInfoMap == nil or tabletool.len(slot0._actInfoMap) == 0 then
		if slot0._actInfoMap == nil then
			slot0._actInfoMap = {}
		end

		for slot7, slot8 in pairs(lua_activity190_episode.configDict[slot0._activityId]) do
			if slot0._actInfoMap[slot7] == nil then
				slot9 = LengZhou6InfoMo.New()

				slot9:init(slot0:getCurActId(), slot7, false)

				slot0._actInfoMap[slot7] = slot9
			end
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		slot0._actInfoMap[slot7.episodeId]:updateInfo(slot7)
	end

	slot0:updateNewestEpisode()
end

function slot0.onFinishActInfo(slot0, slot1)
	slot0._activityId = slot1.activityId

	if slot1.episodeId == nil then
		return
	end

	if slot0._actInfoMap ~= nil and slot0._actInfoMap[slot2] then
		slot3:updateIsFinish(true)
		slot3:updateProgress(slot1.progress)
	end
end

function slot0.onPushActInfo(slot0, slot1)
	slot0._activityId = slot1.activityId

	if not slot1.episodes or #slot2 <= 0 then
		return
	end

	if slot0._actInfoMap == nil or tabletool.len(slot0._actInfoMap) == 0 then
		if slot0._actInfoMap == nil then
			slot0._actInfoMap = {}
		end

		for slot7, slot8 in pairs(lua_activity190_episode.configDict[slot0._activityId]) do
			if slot0._actInfoMap[slot7] == nil then
				slot9 = LengZhou6InfoMo.New()

				slot9:init(slot0:getCurActId(), slot7, false)

				slot0._actInfoMap[slot7] = slot9
			end
		end
	end

	for slot6, slot7 in ipairs(slot2) do
		if slot0._actInfoMap[slot0._actInfoMap[slot7.episodeId].preEpisodeId] then
			slot0._actInfoMap[slot10]:updateIsFinish(true)
		end
	end

	slot0:updateNewestEpisode()
end

function slot0.updateNewestEpisode(slot0)
	slot1, slot2 = nil

	for slot6, slot7 in pairs(slot0._actInfoMap) do
		if slot0:isUnlockEpisode(slot6) and not slot0:isFinishedEpisode(slot6) then
			slot1 = slot6
		end

		if slot0._actInfoMap[slot6]:isEndlessEpisode() then
			slot2 = slot6
		end
	end

	if slot1 == nil then
		slot0._actNewestEpisodeDict[slot0:getCurActId()] = slot2
	else
		slot0._actNewestEpisodeDict[slot3] = slot1
	end
end

function slot0.getAllEpisodeIds(slot0)
	slot2 = {}

	for slot6, slot7 in pairs(lua_activity190_episode.configDict[slot0._activityId]) do
		table.insert(slot2, slot6)
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0 < slot1
	end)

	return slot2
end

function slot0.getEpisodeInfoMo(slot0, slot1)
	return slot0._actInfoMap[slot1]
end

function slot0.getActInfoDic(slot0)
	return slot0._actInfoMap
end

function slot0.isEpisodeFinish(slot0, slot1)
	if slot0._actInfoMap[slot1] == nil then
		return false
	end

	return slot2.isFinish
end

function slot0.setCurEpisodeId(slot0, slot1)
	slot0._curEpisodeId = slot1
end

function slot0.getCurEpisodeId(slot0)
	return slot0._curEpisodeId
end

function slot0.getCurActId(slot0)
	return slot0._activityId
end

function slot0.getEpisodeIsEndLess(slot0, slot1)
	if not string.nilorempty(slot1.enemyId) then
		return slot2 == "2"
	end

	return false
end

function slot0.getAct190Id(slot0)
	return VersionActivity2_7Enum.ActivityId.LengZhou6
end

function slot0.isAct190Open(slot0, slot1)
	slot3, slot4, slot5 = nil

	if ActivityModel.instance:getActivityInfo()[slot0:getAct190Id()] then
		slot3, slot4, slot5 = ActivityHelper.getActivityStatusAndToast(slot2)
	else
		slot4 = ToastEnum.ActivityEnd
	end

	if slot1 and slot4 then
		GameFacade.showToast(slot4, slot5)
	end

	return slot3 == ActivityEnum.ActivityStatus.Normal
end

function slot0.isUnlockEpisode(slot0, slot1)
	return slot0._actInfoMap[slot1] ~= nil and slot2:unLock()
end

function slot0.isFinishedEpisode(slot0, slot1)
	return slot0._actInfoMap[slot1] ~= nil and slot2.isFinish
end

function slot0.getNewestEpisodeId(slot0, slot1)
	return slot0._actNewestEpisodeDict[slot1]
end

slot0.instance = slot0.New()

return slot0
