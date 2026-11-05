-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/hall/ArcadeSurvivorDifficultyViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.hall.ArcadeSurvivorDifficultyViewContainer", package.seeall)

local ArcadeSurvivorDifficultyViewContainer = class("ArcadeSurvivorDifficultyViewContainer", BaseViewContainer)

function ArcadeSurvivorDifficultyViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorDifficultyView.New())

	return views
end

return ArcadeSurvivorDifficultyViewContainer
