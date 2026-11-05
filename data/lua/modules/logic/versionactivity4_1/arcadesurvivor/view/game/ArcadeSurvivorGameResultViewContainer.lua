-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorGameResultViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorGameResultViewContainer", package.seeall)

local ArcadeSurvivorGameResultViewContainer = class("ArcadeSurvivorGameResultViewContainer", BaseViewContainer)

function ArcadeSurvivorGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorGameResultView.New())

	return views
end

return ArcadeSurvivorGameResultViewContainer
