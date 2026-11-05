-- chunkname: @modules/logic/necrologiststory/game/v4a1/V4A1_RoleStoryCheckViewContainer.lua

module("modules.logic.necrologiststory.game.v4a1.V4A1_RoleStoryCheckViewContainer", package.seeall)

local V4A1_RoleStoryCheckViewContainer = class("V4A1_RoleStoryCheckViewContainer", BaseViewContainer)

function V4A1_RoleStoryCheckViewContainer:buildViews()
	local views = {}

	table.insert(views, V4A1_RoleStoryCheckView.New())

	return views
end

return V4A1_RoleStoryCheckViewContainer
