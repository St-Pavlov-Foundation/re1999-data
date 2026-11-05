-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorTipsView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorTipsView", package.seeall)

local ArcadeSurvivorTipsView = class("ArcadeSurvivorTipsView", BaseView)

function ArcadeSurvivorTipsView:onInitView()
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._goroot = gohelper.findChild(self.viewGO, "#go_container/root")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_container/#btn_close")
	self._goMask = gohelper.findChild(self.viewGO, "#go_container/#go_mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorTipsView:_btncloseOnClick()
	if self._tipChildView then
		self._tipChildView:playCloseAnim(self._closeViewWithBlurRefresh, self)
	else
		self:_closeViewWithBlurRefresh()
	end
end

function ArcadeSurvivorTipsView:_closeViewWithBlurRefresh()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.TipViewCloseBlurRefresh, true)
	self:closeView()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.TipViewCloseBlurRefresh, false)
end

function ArcadeSurvivorTipsView:_onCloseView(viewName)
	if viewName == self.viewParam.originalViewName then
		self:closeView()
	end
end

function ArcadeSurvivorTipsView:closeView()
	self:_resetParentRoot()
	self:closeThis()
end

function ArcadeSurvivorTipsView:_editableInitView()
	self._childViewList = {}
end

function ArcadeSurvivorTipsView:onUpdateParam()
	self:_openTipView()
end

function ArcadeSurvivorTipsView:onOpen()
	return
end

function ArcadeSurvivorTipsView:onOpenFinish()
	self:refreshChildView()
	self:setParentRoot()
	gohelper.setActive(self._goMask, self.viewParam.needMask)
end

function ArcadeSurvivorTipsView:_openTipView()
	self:refreshView()
end

function ArcadeSurvivorTipsView:refreshView()
	self:setParentRoot()
	self:refreshChildView()
	gohelper.setActive(self._goMask, self.viewParam.needMask)
end

function ArcadeSurvivorTipsView:refreshChildView()
	local tipType = self.viewParam.tipType

	self._tipChildView = self._childViewList[tipType]

	if not self._tipChildView then
		local viewRes = ArcadeSurvivorEnum.TipTypeRes[tipType]

		if not string.nilorempty(viewRes) then
			local childGO = self:getResInst(viewRes, self._goroot)
			local view = ArcadeSurvivorEnum.TipTypeView[tipType]

			self._tipChildView = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, view)
			self._childViewList[tipType] = self._tipChildView
		end
	end

	for type, view in pairs(self._childViewList) do
		view:showView(type == tipType)
	end

	if self._tipChildView then
		local anchorX, anchorY = 0, 0

		if self.viewParam.anchorPos then
			anchorX, anchorY = self.viewParam.anchorPos.x, self.viewParam.anchorPos.y
		end

		self._tipChildView:setAnchor(self.viewParam, anchorX, anchorY)
		self._tipChildView:onUpdateMO(self.viewParam, self)
	end
end

function ArcadeSurvivorTipsView:setParentRoot()
	if self.viewParam.hideCloseBtn then
		gohelper.setActive(self._btnclose, false)
	else
		gohelper.setActive(self._btnclose, true)
	end

	if not self.viewGO then
		return
	end

	if not self.viewParam.root then
		self:_resetParentRoot()

		return
	end

	gohelper.addChildPosStay(self.viewParam.root, self.viewGO)
	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function ArcadeSurvivorTipsView:_resetParentRoot()
	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_TOP")

	gohelper.addChildPosStay(go, self.viewGO)
	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function ArcadeSurvivorTipsView:onClose()
	return
end

function ArcadeSurvivorTipsView:onDestroyView()
	return
end

return ArcadeSurvivorTipsView
