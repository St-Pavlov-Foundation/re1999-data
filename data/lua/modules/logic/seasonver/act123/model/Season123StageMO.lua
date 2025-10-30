﻿-- chunkname: @modules/logic/seasonver/act123/model/Season123StageMO.lua

module("modules.logic.seasonver.act123.model.Season123StageMO", package.seeall)

local Season123StageMO = pureTable("Season123StageMO")

function Season123StageMO:init(info)
	self.stage = info.stage
	self.isPass = info.isPass == 1
	self.episodeMap = self.episodeMap or {}
	self.minRound = info.minRound
	self.state = info.state or 0

	self:updateEpisodes(info.act123Episodes)
	self:initAssistHeroMO(info)
end

function Season123StageMO:updateEpisodes(episodes)
	local changeSet = {}

	for i = 1, #episodes do
		local episodeData = episodes[i]
		local episodeMO = self.episodeMap[episodeData.layer]

		if not episodeMO then
			episodeMO = Season123EpisodeMO.New()
			self.episodeMap[episodeData.layer] = episodeMO

			episodeMO:init(episodeData)
		else
			episodeMO:update(episodeData)
		end

		changeSet[episodeMO] = true
	end

	for layer, episodeMO in pairs(self.episodeMap) do
		if not changeSet[episodeMO] then
			self.episodeMap[layer] = nil
		end
	end
end

function Season123StageMO:initAssistHeroMO(info)
	logNormal("info.assistHeroInfo.heroUid = [" .. tostring(info.assistHeroInfo.heroUid) .. "], type = " .. type(info.assistHeroInfo.heroUid))

	if info.assistHeroInfo and tostring(info.assistHeroInfo.heroUid) ~= "0" and info.assistHeroInfo.heroId and info.assistHeroInfo.heroId ~= 0 then
		self._assistMO = Season123AssistHeroMO.New()

		self._assistMO:init(info.assistHeroInfo)

		self._assistHeroMO = Season123HeroUtils.createHeroMOByAssistMO(self._assistMO)
	end
end

function Season123StageMO:getAssistHeroMO()
	return self._assistHeroMO, self._assistMO
end

function Season123StageMO:alreadyPass()
	return self.isPass
end

function Season123StageMO:isFinishNow()
	return self.state == 2
end

function Season123StageMO:isNeverTry()
	return self.state == 0
end

function Season123StageMO:updateReduceEpisodeRoundState(layer, state)
	self.reduceState = self.reduceState or {}

	local episodeMO = self.episodeMap[layer]

	self.reduceState[layer] = episodeMO and state or false
end

return Season123StageMO
