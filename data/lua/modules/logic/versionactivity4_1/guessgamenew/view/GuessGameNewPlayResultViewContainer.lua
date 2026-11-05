-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayResultViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayResultViewContainer", package.seeall)

local GuessGameNewPlayResultViewContainer = class("GuessGameNewPlayResultViewContainer", BaseViewContainer)

function GuessGameNewPlayResultViewContainer:buildViews()
	local views = {
		GuessGameNewPlayResultView.New()
	}

	return views
end

return GuessGameNewPlayResultViewContainer
