-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzNewRoundEndFlow.lua

local sf = string.format

module("modules.logic.versionactivity3_7.wmz.flow.WmzNewRoundEndFlow", package.seeall)

local Base = WmzFlowSequence
local WmzNewRoundEndFlow = class("WmzNewRoundEndFlow", Base)

function WmzNewRoundEndFlow:ctor(...)
	Base.ctor(self, ...)
end

function WmzNewRoundEndFlow:onStart()
	local isThisRoundSucc = true
	local isEnddingRound = false

	if isEnddingRound then
		self:addWork(FunctionWork.New(self.completeGame, self, isThisRoundSucc))
	end
end

return WmzNewRoundEndFlow
