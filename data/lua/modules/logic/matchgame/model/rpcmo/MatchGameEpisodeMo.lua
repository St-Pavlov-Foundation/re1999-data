-- chunkname: @modules/logic/matchgame/model/rpcmo/MatchGameEpisodeMo.lua

module("modules.logic.matchgame.model.rpcmo.MatchGameEpisodeMo", package.seeall)

local MatchGameEpisodeMo = class("MatchGameEpisodeMo")

function MatchGameEpisodeMo:init(info)
	self.episodeId = info.episodeId
	self.episodeCo = lua_activity244_episode.configDict[self.episodeId]
	self.matchLevelId = self.episodeCo.matchLevelId
	self.levelCo = lua_activity244_episode_level.configDict[self.matchLevelId]
	self.isPass = info.isPass

	self:_initStarList(info.stars)
end

function MatchGameEpisodeMo:_initStarList(stars)
	self.starNum = stars and #stars or 0
	self.lightStarMap = {}

	for _, starIndex in ipairs(stars) do
		self.lightStarMap[starIndex] = true
	end
end

function MatchGameEpisodeMo:isConditionPass(index)
	return self.lightStarMap and self.lightStarMap[index] == true
end

return MatchGameEpisodeMo
