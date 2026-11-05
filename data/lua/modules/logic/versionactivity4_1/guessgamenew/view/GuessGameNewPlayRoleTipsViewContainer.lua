-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/view/GuessGameNewPlayRoleTipsViewContainer.lua

module("modules.logic.versionactivity4_1.guessgamenew.view.GuessGameNewPlayRoleTipsViewContainer", package.seeall)

local GuessGameNewPlayRoleTipsViewContainer = class("GuessGameNewPlayRoleTipsViewContainer", BaseViewContainer)

function GuessGameNewPlayRoleTipsViewContainer:buildViews()
	local views = {
		GuessGameNewPlayRoleTipsView.New()
	}

	return views
end

return GuessGameNewPlayRoleTipsViewContainer
