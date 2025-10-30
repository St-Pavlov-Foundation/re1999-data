﻿-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapEntrustView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapEntrustView", package.seeall)

local Rouge2_MapEntrustView = class("Rouge2_MapEntrustView", BaseView)

function Rouge2_MapEntrustView:onInitView()
	self._goEntrustContainer = gohelper.findChild(self.viewGO, "Left/#go_entrustcontainer")
	self._btnEntrust = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#go_entrustcontainer/#btn_entrust")
	self._goentrustlist = gohelper.findChild(self.viewGO, "Left/#go_entrustcontainer/#go_entrustlist")
	self._goentrustitem = gohelper.findChild(self.viewGO, "Left/#go_entrustcontainer/#go_entrustlist/#go_entrustitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapEntrustView:addEvents()
	self._btnEntrust:AddClickListener(self._btnEntrustOnClick, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onClearInteract, self.onClearInteract, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onPopViewDone, self.onPopViewDone, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onAcceptEntrust, self.onAcceptEntrust, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onEntrustChange, self.onEntrustChange, self)
end

function Rouge2_MapEntrustView:removeEvents()
	self._btnEntrust:RemoveClickListener()
end

function Rouge2_MapEntrustView:_btnEntrustOnClick()
	ViewMgr.instance:openView(ViewName.Rouge2_MapEntrustDetailView)
end

function Rouge2_MapEntrustView:onAcceptEntrust(entrustIdList)
	if not entrustIdList or #entrustIdList <= 0 then
		return
	end
end

function Rouge2_MapEntrustView:onEntrustChange()
	local curDoingNum = Rouge2_MapModel.instance:getDoingEntrustNum()

	if curDoingNum < self.doingEntrustNum then
		self.preEntrustList = self.preEntrustList or {}

		tabletool.addValues(self.preEntrustList, self.entrustList)

		self.isEntrustNewFinish = true

		self:tryShowFinishEntrustEffect()

		return
	end

	self:tryShowEntrust()
end

function Rouge2_MapEntrustView:onCloseViewFinish()
	self:tryShowFinishEntrustEffect()
end

function Rouge2_MapEntrustView:onClearInteract()
	self:tryShowFinishEntrustEffect()
end

function Rouge2_MapEntrustView:onPopViewDone()
	self:tryShowFinishEntrustEffect()
end

function Rouge2_MapEntrustView:tryShowFinishEntrustEffect()
	if not self.isEntrustNewFinish then
		return
	end

	if not Rouge2_MapHelper.checkMapViewOnTop() then
		return
	end

	local isPop = Rouge2_PopController.instance:isPopping()

	if isPop then
		return
	end

	local interactive = Rouge2_MapModel.instance:isInteractiving()

	if interactive then
		return
	end

	self.isEntrustNewFinish = false

	self:refreshTmpEntrust()
	TaskDispatcher.cancelTask(self.tryShowEntrust, self)
	TaskDispatcher.runDelay(self.tryShowEntrust, self, Rouge2_MapEnum.EntrustFinishDuration)
end

function Rouge2_MapEntrustView:_editableInitView()
	self._animator = ZProj.ProjAnimatorPlayer.Get(self._goEntrustContainer)
	self._canvasgroup = gohelper.onceAddComponent(self._goEntrustContainer, gohelper.Type_CanvasGroup)
	self.preHadEntrust = false
end

function Rouge2_MapEntrustView:onOpen()
	self:tryShowEntrust()
end

function Rouge2_MapEntrustView:tryShowEntrust()
	self.isEntrustNewFinish = false
	self.status = Rouge2_MapEnum.EntrustStatus.Detail

	self:updateHadEntrust()
	self:refreshEntrust()
end

function Rouge2_MapEntrustView:updateHadEntrust()
	self.entrustList = Rouge2_MapModel.instance:getDoingEntrustList()
	self.doingEntrustNum = Rouge2_MapModel.instance:getDoingEntrustNum()
	self.preHadEntrust = self.hadEntrust
	self.hadEntrust = self.doingEntrustNum > 0
	self.preEntrustList = {}
end

function Rouge2_MapEntrustView:refreshTmpEntrust()
	gohelper.CreateObjList(self, self._refreshEntrustItem, self.preEntrustList, self._goentrustlist, self._goentrustitem, Rouge2_MapEntrustInfoItem)
	self:refreshStatus()
end

function Rouge2_MapEntrustView:refreshEntrust()
	self:_lock(false)

	if not self.hadEntrust then
		self:hideEntrust()

		return
	end

	if self.preHadEntrust ~= self.hadEntrust then
		gohelper.setActive(self._goEntrustContainer, true)
		self:_lock(true)
		self._animator:Play("in", self._onOpenEntrustAnimDone, self)
	end

	gohelper.CreateObjList(self, self._refreshEntrustItem, self.entrustList, self._goentrustlist, self._goentrustitem, Rouge2_MapEntrustInfoItem)
	self:refreshStatus()
end

function Rouge2_MapEntrustView:_refreshEntrustItem(entrustItem, entrustMo, index)
	entrustItem:onUpdateMO(index, entrustMo)
end

function Rouge2_MapEntrustView:refreshStatus()
	gohelper.setActive(self._goEntrustContainer, self.status == Rouge2_MapEnum.EntrustStatus.Detail)
end

function Rouge2_MapEntrustView:hideEntrust()
	if self.preHadEntrust ~= self.hadEntrust then
		gohelper.setActive(self._goEntrustContainer, true)
		self:_lock(true)
		self._animator:Play("out", self._onCloseEntrustAnimDone, self)

		return
	end

	self:_onCloseEntrustAnimDone()
end

function Rouge2_MapEntrustView:_onCloseEntrustAnimDone()
	self:_lock(true)
	gohelper.setActive(self._goEntrustContainer, false)
end

function Rouge2_MapEntrustView:_onOpenEntrustAnimDone()
	self:_lock(false)
	gohelper.setActive(self._goEntrustContainer, true)
end

function Rouge2_MapEntrustView:_lock(lock)
	self._canvasgroup.blocksRaycasts = not lock
end

function Rouge2_MapEntrustView:onClose()
	self.closing = nil

	TaskDispatcher.cancelTask(self.tryShowEntrust, self)
end

return Rouge2_MapEntrustView
