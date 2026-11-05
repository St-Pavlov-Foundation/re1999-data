-- chunkname: @modules/logic/versionactivity4_1/library/scene/V4a1_Library_LoadingContainer.lua

module("modules.logic.versionactivity4_1.library.scene.V4a1_Library_LoadingContainer", package.seeall)

local V4a1_Library_LoadingContainer = class("V4a1_Library_LoadingContainer", BaseViewContainer)

function V4a1_Library_LoadingContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_Library_Loading.New())

	return views
end

return V4a1_Library_LoadingContainer
