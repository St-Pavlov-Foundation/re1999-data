﻿-- chunkname: @modules/versionactivitybase/fixed/enterview/view/VersionActivityFixedEnterViewTabItem2.lua

module("modules.versionactivitybase.fixed.enterview.view.VersionActivityFixedEnterViewTabItem2", package.seeall)

local VersionActivityFixedEnterViewTabItem2 = class("VersionActivityFixedEnterViewTabItem2", VersionActivityFixedEnterViewTabItemBase)

function VersionActivityFixedEnterViewTabItem2:_editableInitView()
	VersionActivityFixedEnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivityFixedEnterViewTabItem2:afterSetData()
	VersionActivityFixedEnterViewTabItem2.super.afterSetData(self)

	local singleLineHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(self.txtName, " ")

	self.txtName.text = self.activityCo and self.activityCo.name or ""
	self.txtNameEn.text = self.activityCo and self.activityCo.nameEn or ""

	ZProj.UGUIHelper.RebuildLayout(self.txtName.transform)

	local nameheight = self.txtName.preferredHeight
	local layoutElement = self.go:GetComponent(typeof(UnityEngine.UI.LayoutElement))

	layoutElement.minHeight = layoutElement.minHeight + nameheight - singleLineHeight
end

function VersionActivityFixedEnterViewTabItem2:childRefreshSelect(actId)
	VersionActivityFixedEnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivityFixedHelper.getVersionActivityEnum().TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivityFixedEnterViewTabItem2
