﻿-- chunkname: @modules/logic/activity/view/VersionSummonPanel_Part1.lua

module("modules.logic.activity.view.VersionSummonPanel_Part1", package.seeall)

local VersionSummonPanel_Part1 = class("VersionSummonPanel_Part1", VersionSummonPanel)

function VersionSummonPanel_Part1:_editableInitView()
	self._simageRole:LoadImage(ResUrl.getVersionSummonSingleBg("versionsummon_rolepanel_1"))
	self._simageTitle:LoadImage(ResUrl.getVersionSummonSingleBgLang("versionsummon_txt_1"))

	self._txtTips.text = luaLang("versionsummon_txt_tips1")
end

return VersionSummonPanel_Part1
