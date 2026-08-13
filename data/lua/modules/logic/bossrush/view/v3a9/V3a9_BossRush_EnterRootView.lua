-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_EnterRootView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_EnterRootView", package.seeall)

local V3a9_BossRush_EnterRootView = class("V3a9_BossRush_EnterRootView", VersionActivityEnterBaseSubView)

function V3a9_BossRush_EnterRootView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_EnterRootView:addEvents()
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refresh, self)
end

function V3a9_BossRush_EnterRootView:removeEvents()
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refresh, self)
end

function V3a9_BossRush_EnterRootView:_editableInitView()
	self._enterViews = self:getUserDataTb_()
end

function V3a9_BossRush_EnterRootView:_showEnterView(tab)
	if not self._enterViews[tab] then
		local index = tab == V3a9BossRushEnum.Mode.Act and 2 or 1
		local path = self.viewContainer:getSetting().otherRes[index]

		if path then
			local childGO = self:getResInst(path, self._goroot)
			local view = tab == V3a9BossRushEnum.Mode.Act and V3a9_BossRush_ActEnterView or V3a9_BossRush_NormalEnterView
			local childView = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, view)

			self._enterViews[tab] = childView
		end
	end

	for _tab, view in pairs(self._enterViews) do
		view:onShow(_tab == tab)
	end
end

function V3a9_BossRush_EnterRootView:onOpen()
	self:_refresh()
end

function V3a9_BossRush_EnterRootView:_refresh()
	local actId = V3a9_BossRushModel.instance:getActModeActId()
	local isOpen = ActivityHelper.isOpen(actId)
	local view = isOpen and V3a9BossRushEnum.Mode.Act or V3a9BossRushEnum.Mode.Normal

	self:_showEnterView(view)
end

function V3a9_BossRush_EnterRootView:everySecondCall()
	for _, view in pairs(self._enterViews) do
		view:everySecondCall()
	end
end

return V3a9_BossRush_EnterRootView
