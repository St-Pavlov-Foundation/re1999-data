-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorTipsViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorTipsViewContainer", package.seeall)

local ArcadeSurvivorTipsViewContainer = class("ArcadeSurvivorTipsViewContainer", BaseViewContainer)

function ArcadeSurvivorTipsViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorTipsView.New())

	return views
end

return ArcadeSurvivorTipsViewContainer
