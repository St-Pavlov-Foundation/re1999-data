-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorEventSelectViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorEventSelectViewContainer", package.seeall)

local ArcadeSurvivorEventSelectViewContainer = class("ArcadeSurvivorEventSelectViewContainer", BaseViewContainer)

function ArcadeSurvivorEventSelectViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorEventSelectView.New())

	return views
end

return ArcadeSurvivorEventSelectViewContainer
