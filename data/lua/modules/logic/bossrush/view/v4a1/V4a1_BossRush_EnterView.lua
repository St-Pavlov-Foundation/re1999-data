-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_EnterView.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_EnterView", package.seeall)

local V4a1_BossRush_EnterView = class("V4a1_BossRush_EnterView", V3a2_BossRush_EnterView)

function V4a1_BossRush_EnterView:_enterActivity()
	if self._isInfo then
		V4a1_BossRushController.instance:openMainView()
	end
end

function V4a1_BossRush_EnterView:_getRankBtnPath()
	local seasonParam = V4a1BossRushEnum.SeasonParam[2]

	return seasonParam.RankBtnPath
end

function V4a1_BossRush_EnterView:refreshSeason()
	self._season = 2
end

return V4a1_BossRush_EnterView
