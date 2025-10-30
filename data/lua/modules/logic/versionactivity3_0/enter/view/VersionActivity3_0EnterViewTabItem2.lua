﻿-- chunkname: @modules/logic/versionactivity3_0/enter/view/VersionActivity3_0EnterViewTabItem2.lua

module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterViewTabItem2", package.seeall)

local VersionActivity3_0EnterViewTabItem2 = class("VersionActivity3_0EnterViewTabItem2", VersionActivity3_0EnterViewTabItemBase)

function VersionActivity3_0EnterViewTabItem2:_editableInitView()
	VersionActivity3_0EnterViewTabItem2.super._editableInitView(self)

	self.txtName = gohelper.findChildText(self.go, "#txt_name")
	self.txtNameEn = gohelper.findChildText(self.go, "#txt_name/#txt_nameen")
end

function VersionActivity3_0EnterViewTabItem2:afterSetData()
	VersionActivity3_0EnterViewTabItem2.super.afterSetData(self)

	self.txtName.text = self.activityCo and self.activityCo.name or ""
	self.txtNameEn.text = self.activityCo and self.activityCo.nameEn or ""

	local width = self.txtName.preferredWidth
	local defaultTextWidth = 132
	local defalutPreferredWidth = 300

	if defaultTextWidth < width then
		local layoutComp = self.go:GetComponent(typeof(UnityEngine.UI.LayoutElement))

		if layoutComp then
			layoutComp.preferredWidth = defalutPreferredWidth + (width - defaultTextWidth)
		end
	end
end

function VersionActivity3_0EnterViewTabItem2:childRefreshSelect(actId)
	VersionActivity3_0EnterViewTabItem2.super.childRefreshSelect(self, actId)

	local tabSetting = VersionActivity3_0Enum.TabSetting.unselect

	if self.isSelect then
		tabSetting = VersionActivity3_0Enum.TabSetting.select
	end

	self.txtName.color = GameUtil.parseColor(tabSetting.cnColor)
	self.txtNameEn.color = GameUtil.parseColor(tabSetting.enColor)
	self.txtName.fontSize = tabSetting.fontSize
	self.txtNameEn.fontSize = tabSetting.enFontSize
end

return VersionActivity3_0EnterViewTabItem2
