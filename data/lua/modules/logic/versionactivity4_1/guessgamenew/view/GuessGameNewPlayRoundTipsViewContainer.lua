-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayRoundTipsViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayRoundTipsViewContainer", package.seeall)

local GuessGameNewPlayRoundTipsViewContainer = class("GuessGameNewPlayRoundTipsViewContainer", BaseViewContainer)

function GuessGameNewPlayRoundTipsViewContainer:buildViews()
	local views = {
		GuessGameNewPlayRoundTipsView.New()
	}

	return views
end

return GuessGameNewPlayRoundTipsViewContainer
