-- chunkname: @modules/logic/college/view/other/CollegeRoundEndAnimViewContainer.lua

module("modules.logic.college.view.other.CollegeRoundEndAnimViewContainer", package.seeall)

local CollegeRoundEndAnimViewContainer = class("CollegeRoundEndAnimViewContainer", BaseViewContainer)

function CollegeRoundEndAnimViewContainer:buildViews()
	return {}
end

function CollegeRoundEndAnimViewContainer:onContainerOpen()
	CollegeAudioHelper.instance:playAudio(CollegeAudioEnum.RoundEnd)

	UIBlockMgrExtend.CircleMvDelay = 10

	UIBlockMgrExtend.instance:resetMaskShow()
	CollegeHelper.instance:setViewVisible(self.viewName, true)
end

function CollegeRoundEndAnimViewContainer:onContainerOpenFinish()
	TaskDispatcher.runDelay(self.closeThis, self, 1.5)
end

function CollegeRoundEndAnimViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

function CollegeRoundEndAnimViewContainer:onContainerClose()
	UIBlockMgrExtend.CircleMvDelay = nil

	CollegeHelper.instance:setViewVisible(self.viewName, false)
	TaskDispatcher.cancelTask(self.closeThis, self)
end

return CollegeRoundEndAnimViewContainer
