module("modules.logic.versionactivity2_7.lengzhou6.model.LengZhou6InfoMo", package.seeall)

slot0 = pureTable("LengZhou6InfoMo")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.actId = slot1
	slot0.episodeId = slot2
	slot0.isFinish = slot3

	if LengZhou6Config.instance:getEpisodeConfig(slot0.actId, slot0.episodeId) == nil then
		logError("config is nil" .. slot2)

		return
	end

	slot0._config = slot4
	slot0.preEpisodeId = slot4.preEpisodeId
end

function slot0.updateInfo(slot0, slot1)
	slot0:updateIsFinish(slot1.isFinished)

	slot0.progress = slot1.progress
end

function slot0.updateIsFinish(slot0, slot1)
	slot0.isFinish = slot1
end

function slot0.updateProgress(slot0, slot1)
	slot0.progress = slot1
end

function slot0.isEndlessEpisode(slot0)
	return LengZhou6Model.instance:getEpisodeIsEndLess(slot0._config)
end

function slot0.getEpisodeName(slot0)
	return slot0._config.name
end

function slot0.haveEliminate(slot0)
	return slot0._config.eliminateLevelId ~= 0
end

function slot0.isDown(slot0)
	return slot0.episodeId % 2 ~= 0
end

function slot0.canShowItem(slot0)
	if slot0:isEndlessEpisode() then
		return slot0:unLock()
	end

	return true
end

function slot0.unLock(slot0)
	return slot0.preEpisodeId == 0 or LengZhou6Model.instance:isEpisodeFinish(slot1)
end

function slot0.getLevel(slot0)
	if not string.nilorempty(slot0.progress) then
		return cjson.decode(slot0.progress).endLessLayer or LengZhou6Enum.DefaultEndLessBeginRound
	end

	return LengZhou6Enum.DefaultEndLessBeginRound
end

function slot0.getEndLessBattleProgress(slot0)
	if not string.nilorempty(slot0.progress) then
		return cjson.decode(slot0.progress).endLessBattleProgress
	end

	return nil
end

function slot0.setProgress(slot0, slot1)
	slot0.progress = slot1
end

return slot0
