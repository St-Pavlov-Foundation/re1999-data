-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_ResultPanelContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_ResultPanelContainer", package.seeall)

local V4a1_BossRush_ResultPanelContainer = class("V4a1_BossRush_ResultPanelContainer", BaseViewContainer)

function V4a1_BossRush_ResultPanelContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_BossRush_ResultPanel.New())

	return views
end

return V4a1_BossRush_ResultPanelContainer
