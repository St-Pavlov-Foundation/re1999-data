﻿-- chunkname: @modules/logic/versionactivity2_6/warmup/view/V2a6_WarmUp_radiotaskitem.lua

module("modules.logic.versionactivity2_6.warmup.view.V2a6_WarmUp_radiotaskitem", package.seeall)

local V2a6_WarmUp_radiotaskitem = class("V2a6_WarmUp_radiotaskitem", RougeSimpleItemBase)

function V2a6_WarmUp_radiotaskitem:onInitView()
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a6_WarmUp_radiotaskitem:addEvents()
	return
end

function V2a6_WarmUp_radiotaskitem:removeEvents()
	return
end

function V2a6_WarmUp_radiotaskitem:ctor(ctorParam)
	V2a6_WarmUp_radiotaskitem.super.ctor(self, ctorParam)
end

function V2a6_WarmUp_radiotaskitem:_editableInitView()
	V2a6_WarmUp_radiotaskitem.super._editableInitView(self)

	self._txtDateUnSelected = gohelper.findChildText(self.viewGO, "txt_DateUnSelected")
	self._goDateSelected = gohelper.findChild(self.viewGO, "image_Selected")
	self._txtDateSelected = gohelper.findChildText(self.viewGO, "image_Selected/txt_DateSelected")
	self._finishEffectGo = gohelper.findChild(self.viewGO, "image_Selected/Wave_effect2")
	self._imagewave = gohelper.findChildImage(self.viewGO, "image_Selected/image_wave")
	self._goDateLocked = gohelper.findChild(self.viewGO, "image_Locked")
	self._goRed = gohelper.findChild(self.viewGO, "#go_reddot")
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._txtDateUnSelectedGo = self._txtDateUnSelected.gameObject
end

function V2a6_WarmUp_radiotaskitem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function V2a6_WarmUp_radiotaskitem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function V2a6_WarmUp_radiotaskitem:onSelect(isSelect)
	gohelper.setActive(self._goDateSelected, isSelect)
	gohelper.setActive(self._txtDateUnSelectedGo, not isSelect)
end

function V2a6_WarmUp_radiotaskitem:onDestroyView()
	V2a6_WarmUp_radiotaskitem.super.onDestroyView(self)
end

function V2a6_WarmUp_radiotaskitem:_getEpisodeConfig(episodeId)
	return self:_assetGetViewContainer():getEpisodeConfig(episodeId)
end

function V2a6_WarmUp_radiotaskitem:_getRLOC(episodeId)
	return self:_assetGetViewContainer():getRLOC(episodeId)
end

function V2a6_WarmUp_radiotaskitem:_isEpisodeDayOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeDayOpen(episodeId)
end

function V2a6_WarmUp_radiotaskitem:_isEpisodeUnLock(episodeId)
	return self:_assetGetViewContainer():isEpisodeUnLock(episodeId)
end

function V2a6_WarmUp_radiotaskitem:_isEpisodeReallyOpen(episodeId)
	return self:_assetGetViewContainer():isEpisodeReallyOpen(episodeId)
end

function V2a6_WarmUp_radiotaskitem:setData(mo)
	self._mo = mo

	local episodeId = mo
	local episodeCfg = self:_getEpisodeConfig(episodeId)
	local openDay = episodeCfg.openDay
	local isLock = not self:_isEpisodeReallyOpen(episodeId)
	local isRecevied = self:_getRLOC(episodeId)
	local showReddot = not isLock and not isRecevied
	local openDayDesc = "Day." .. tostring(openDay)

	self._txtDateUnSelected.text = openDayDesc
	self._txtDateSelected.text = openDayDesc

	gohelper.setActive(self._goDateLocked, isLock)
	gohelper.setActive(self._goRed, showReddot)
end

function V2a6_WarmUp_radiotaskitem:_onClick()
	local p = self:_assetGetParent()

	if not self:_checkIfOpenAndToast() then
		return
	end

	p:onClickTab(self._mo)
end

function V2a6_WarmUp_radiotaskitem:_checkIfOpenAndToast()
	local mo = self._mo
	local episodeId = mo
	local isOpen, remainDay = self:_isEpisodeDayOpen(episodeId)

	if not isOpen then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen, remainDay)

		return false
	end

	if not self:_isEpisodeReallyOpen(episodeId) then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeLock)

		return false
	end

	return true
end

return V2a6_WarmUp_radiotaskitem
