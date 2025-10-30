﻿-- chunkname: @modules/logic/handbook/view/HandbookSkinSuitComp.lua

module("modules.logic.handbook.view.HandbookSkinSuitComp", package.seeall)

local HandbookSkinSuitComp = class("HandbookSkinSuitComp", LuaCompBase)

function HandbookSkinSuitComp:ctor(param)
	self._suitId = param[1]
	self._skinCfg = HandbookConfig.instance:getSkinSuitCfg(self._suitId)
end

function HandbookSkinSuitComp:init(go)
	self._go = go
	self._goSuitName = gohelper.findChild(self._go, "root/loop/scence/zh_text")
	self._goSuitNameEn = gohelper.findChild(self._go, "root/loop/scence/en_text")

	if self._skinCfg.show ~= 1 then
		gohelper.setActive(self._goSuitName, false)
		gohelper.setActive(self._goSuitNameEn, false)
	else
		self._textSuitName = self._goSuitName and self._goSuitName:GetComponent(typeof(TMPro.TextMeshPro))
		self._textSuitNameEn = self._goSuitNameEn and self._goSuitNameEn:GetComponent(typeof(TMPro.TextMeshPro))

		if self._textSuitName then
			self._textSuitName.text = self._skinCfg.name
		end

		if self._textSuitNameEn then
			self._textSuitNameEn.text = self._skinCfg.nameEn
		end
	end
end

function HandbookSkinSuitComp:addEventListeners()
	return
end

function HandbookSkinSuitComp:removeEventListeners()
	return
end

function HandbookSkinSuitComp:onStart()
	return
end

function HandbookSkinSuitComp:dispose()
	return
end

function HandbookSkinSuitComp:onDestroy()
	return
end

return HandbookSkinSuitComp
