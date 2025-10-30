﻿-- chunkname: @modules/logic/pcInput/View/keyTipsView.lua

module("modules.logic.pcInput.View.keyTipsView", package.seeall)

local keyTipsView = class("keyTipsView", LuaCompBase)
local ResPath = "ui/viewres/pc/pcbuttonitem.prefab"

function keyTipsView:ctor(param)
	self._keyName = param.keyname
	self._activityid = param.activityId
	self._keyid = param.keyid
end

function keyTipsView:init(go)
	self._go = go

	self:load()
end

function keyTipsView:load()
	self._loader = PrefabInstantiate.Create(self._go)

	self._loader:startLoad(ResPath, keyTipsView._onCallback, self)
end

function keyTipsView:_onCallback()
	self._instGO = self._loader:getInstGO()

	local keyTips = PlayerPrefsHelper.getNumber("keyTips", 0)

	if keyTips == 0 then
		self._instGO:SetActive(false)

		return
	else
		self._instGO:SetActive(true)
	end

	gohelper.setActive(self._instGO, not ViewMgr.instance:isOpen(ViewName.GuideView))

	self._text1 = gohelper.findChildText(self._instGO, "btn_1/#txt_btn")
	self._text2 = gohelper.findChildText(self._instGO, "btn_2/#txt_btn")
	self._btn1 = gohelper.findChild(self._instGO, "btn_1")
	self._btn2 = gohelper.findChild(self._instGO, "btn_2")

	local key = self._keyName or PCInputModel.instance:getKey(self._activityid, self._keyid)

	if self:selectType(key) == 1 then
		self._btn1:SetActive(true)
		self._btn2:SetActive(false)

		self._text1.text = PCInputController.instance:KeyNameToDescName(key)
	else
		self._btn1:SetActive(false)
		self._btn2:SetActive(true)

		self._text2.text = PCInputController.instance:KeyNameToDescName(key)
	end
end

function keyTipsView:Show(bshow)
	if self._instGO then
		self._instGO:SetActive(bshow and not ViewMgr.instance:isOpen(ViewName.GuideView) and PlayerPrefsHelper.getNumber("keyTips", 0) == 1)
	end
end

function keyTipsView:selectType(key)
	if string.len(key) > 1 then
		return 2
	else
		return 1
	end
end

function keyTipsView:Refresh(activityId, keyid)
	self._activityid = activityId
	self._keyid = keyid
	self._keyName = nil

	if self._instGO then
		self:_onCallback()
	end
end

function keyTipsView:RefreshByKeyName(keyName)
	self._keyName = keyName
	self._activityid = nil
	self._keyid = nil

	if self._instGO then
		self:_onCallback()
	end
end

function keyTipsView:addEventListeners()
	self:addEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, self._onCallback, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function keyTipsView:removeEventListeners()
	self:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, self._onCallback, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenViewCallBack, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self.onCloseViewCallBack, self)
end

function keyTipsView:onOpenViewCallBack(viewName)
	if viewName == ViewName.GuideView then
		self._instGO:SetActive(false)
	end
end

function keyTipsView:onCloseViewCallBack(viewName)
	if viewName == ViewName.GuideView then
		self._instGO:SetActive(true)
	end
end

function keyTipsView:onStart()
	return
end

function keyTipsView:onDestroy()
	return
end

return keyTipsView
