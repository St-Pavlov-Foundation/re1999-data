-- chunkname: @modules/logic/matchgame/outside/result/MatchGameResultViewContainer.lua

module("modules.logic.matchgame.outside.result.MatchGameResultViewContainer", package.seeall)

local MatchGameResultViewContainer = class("MatchGameResultViewContainer", BaseViewContainer)

function MatchGameResultViewContainer:buildViews()
	return {
		MatchGameResultView.New()
	}
end

function MatchGameResultViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local isSuccess = self.viewParam and self.viewParam.isSuccess
	local openAnimName = isSuccess and "success" or "failure"
	local animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(openAnimName, self.onPlayOpenTransitionFinish, self)
end

return MatchGameResultViewContainer
