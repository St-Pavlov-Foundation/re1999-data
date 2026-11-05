-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_ResultViewContainer.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_ResultViewContainer", package.seeall)

local V4a1_BossRush_ResultViewContainer = class("V4a1_BossRush_ResultViewContainer", BaseViewContainer)

function V4a1_BossRush_ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V4a1_BossRush_ResultView.New())

	return views
end

return V4a1_BossRush_ResultViewContainer
