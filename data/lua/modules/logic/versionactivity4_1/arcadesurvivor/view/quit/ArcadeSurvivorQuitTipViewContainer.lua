-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/quit/ArcadeSurvivorQuitTipViewContainer.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.quit.ArcadeSurvivorQuitTipViewContainer", package.seeall)

local ArcadeSurvivorQuitTipViewContainer = class("ArcadeSurvivorQuitTipViewContainer", BaseViewContainer)

function ArcadeSurvivorQuitTipViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeSurvivorQuitTipView.New())

	return views
end

return ArcadeSurvivorQuitTipViewContainer
