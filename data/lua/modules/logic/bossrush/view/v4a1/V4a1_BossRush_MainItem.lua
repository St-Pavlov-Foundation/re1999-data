-- chunkname: @modules/logic/bossrush/view/v4a1/V4a1_BossRush_MainItem.lua

module("modules.logic.bossrush.view.v4a1.V4a1_BossRush_MainItem", package.seeall)

local V4a1_BossRush_MainItem = class("V4a1_BossRush_MainItem", V3a2_BossRush_MainItem)

function V4a1_BossRush_MainItem:_onClick()
	V4a1_BossRushController.instance:openLevelDetailView(self._mo)
	self:_checkNewUnlock()
	self:_refreshReddotType()
end

return V4a1_BossRush_MainItem
