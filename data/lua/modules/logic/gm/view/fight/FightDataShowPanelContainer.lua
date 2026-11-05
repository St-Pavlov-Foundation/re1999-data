-- chunkname: @modules/logic/gm/view/fight/FightDataShowPanelContainer.lua

module("modules.logic.gm.view.fight.FightDataShowPanelContainer", package.seeall)

local FightDataShowPanelContainer = class("FightDataShowPanelContainer", BaseViewContainer)

function FightDataShowPanelContainer:buildViews()
	local views = {}

	table.insert(views, FightDataShowPanel.New())

	return views
end

return FightDataShowPanelContainer
