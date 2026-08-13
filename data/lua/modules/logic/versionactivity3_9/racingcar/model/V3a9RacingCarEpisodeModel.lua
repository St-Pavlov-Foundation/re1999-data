-- chunkname: @modules/logic/versionactivity3_9/racingcar/model/V3a9RacingCarEpisodeModel.lua

module("modules.logic.versionactivity3_9.racingcar.model.V3a9RacingCarEpisodeModel", package.seeall)

local V3a9RacingCarEpisodeModel = class("V3a9RacingCarEpisodeModel", BaseModel)

function V3a9RacingCarEpisodeModel:onInit()
	self:reInit()
end

function V3a9RacingCarEpisodeModel:reInit()
	self._episodes = {}
end

function V3a9RacingCarEpisodeModel:initInfo(episodes)
	self._totalStarCount = 0

	for i, v in ipairs(episodes) do
		self:updateEpisodeInfo(v)

		self._totalStarCount = self._totalStarCount + v.bestStar
	end
end

function V3a9RacingCarEpisodeModel:updateEpisodeInfo(v)
	local info = self._episodes[v.episodeId] or {}

	info.episodeId = v.episodeId
	info.episodeType = v.episodeType
	info.isFinished = v.isFinished
	info.bestScore = v.bestScore
	info.bestStar = v.bestStar
	info.bestTimeMs = v.bestTimeMs
	info.claimedStars = v.claimedStars
	info.record = v.record
	self._episodes[info.episodeId] = info

	self:_finishGuides(info.episodeId, info.isFinished)
end

function V3a9RacingCarEpisodeModel:_finishGuides(episodeId, isFinished)
	if not GuideController.instance:isForbidGuides() and isFinished then
		local guideList = V3a9RacingCarEnum.EpisodeGuideMap[episodeId]

		if not guideList then
			return
		end

		for _, guideId in ipairs(guideList) do
			if not GuideModel.instance:isGuideFinish(guideId) then
				GuideController.instance:oneKeyFinishGuide(guideId, true)
			end
		end
	end
end

function V3a9RacingCarEpisodeModel:getEpisodeInfo(episodeId)
	return self._episodes[episodeId]
end

function V3a9RacingCarEpisodeModel:getTotalStar()
	return self._totalStarCount or 0
end

V3a9RacingCarEpisodeModel.instance = V3a9RacingCarEpisodeModel.New()

return V3a9RacingCarEpisodeModel
