-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/handbook/ArcadeSurvivorHandBookViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.handbook.ArcadeSurvivorHandBookViewContainer", package.seeall)

local ArcadeSurvivorHandBookViewContainer = class("ArcadeSurvivorHandBookViewContainer", BaseViewContainer)

function ArcadeSurvivorHandBookViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorHandBookView.New())
	table.insert(views, ArcadeSurvivorHandBookInfoView.New())

	return views
end

return ArcadeSurvivorHandBookViewContainer
