﻿-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ResultViewContainer.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ResultViewContainer", package.seeall)

local V1a4_BossRush_ResultViewContainer = class("V1a4_BossRush_ResultViewContainer", BaseViewContainer)

function V1a4_BossRush_ResultViewContainer:buildViews()
	local views = {
		(V1a4_BossRush_ResultView.New())
	}

	return views
end

function V1a4_BossRush_ResultViewContainer:buildTabViews(tabContainerId)
	return
end

return V1a4_BossRush_ResultViewContainer
