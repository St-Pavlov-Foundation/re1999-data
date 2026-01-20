-- chunkname: @modules/logic/partygame/games/CollatingSortPartyGame.lua

module("modules.logic.partygame.games.CollatingSortPartyGame", package.seeall)

local CollatingSortPartyGame = class("CollatingSortPartyGame", PartyGameBase)

function CollatingSortPartyGame:getGameViewName()
	return ViewName.CollatingSortGameView
end

function CollatingSortPartyGame:getPlayerScore(uid)
	if self._csGameBase == nil or uid == nil then
		return 0
	end

	local score = PartyGameCSDefine.CollatingSortGameInterface.GetPlayerScore(uid)

	return score
end

return CollatingSortPartyGame
