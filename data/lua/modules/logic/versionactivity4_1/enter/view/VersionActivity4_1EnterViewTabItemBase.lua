-- chunkname: @modules/logic/versionactivity4_1/enter/view/VersionActivity4_1EnterViewTabItemBase.lua

module("modules.logic.versionactivity4_1.enter.view.VersionActivity4_1EnterViewTabItemBase", package.seeall)

local VersionActivity4_1EnterViewTabItemBase = class("VersionActivity4_1EnterViewTabItemBase", VersionActivityFixedEnterViewTabItemBase)

function VersionActivity4_1EnterViewTabItemBase:_editableInitView()
	VersionActivity4_1EnterViewTabItemBase.super._editableInitView(self)

	self._canvasGroup = self.go:GetComponent(gohelper.Type_CanvasGroup)
end

function VersionActivity4_1EnterViewTabItemBase:setAlpha(alpha)
	self._canvasGroup.alpha = alpha
end

return VersionActivity4_1EnterViewTabItemBase
