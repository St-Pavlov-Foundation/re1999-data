-- chunkname: @modules/logic/college/view/common/CollegeVisibleBaseView.lua

module("modules.logic.college.view.common.CollegeVisibleBaseView", package.seeall)

local CollegeVisibleBaseView = class("CollegeVisibleBaseView", BaseView)

function CollegeVisibleBaseView:addEvents()
	CollegeController.instance:registerCallback(CollegeEvent.OnViewVisibleChange, self._onViewVisibleChange, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, self._onViewVisibleChange, self)
end

function CollegeVisibleBaseView:removeEvents()
	CollegeController.instance:unregisterCallback(CollegeEvent.OnViewVisibleChange, self._onViewVisibleChange, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, self._onViewVisibleChange, self)
end

function CollegeVisibleBaseView:onOpen()
	self:_onViewVisibleChange()
end

function CollegeVisibleBaseView:_onViewVisibleChange()
	self:setVisible(CollegeModel.instance:isViewVisible(self.viewName))
end

function CollegeVisibleBaseView:setVisible(isShow)
	self.isHide = not isShow

	if not self._canvasGroup then
		self._canvasGroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	end

	self._canvasGroup.alpha = self.isHide and 0 or 1
	self._canvasGroup.blocksRaycasts = isShow
end

return CollegeVisibleBaseView
