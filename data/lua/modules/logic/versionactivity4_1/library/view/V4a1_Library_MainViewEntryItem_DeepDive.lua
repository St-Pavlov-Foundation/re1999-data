-- chunkname: @modules/logic/versionactivity4_1/library/view/V4a1_Library_MainViewEntryItem_DeepDive.lua

module("modules.logic.versionactivity4_1.library.view.V4a1_Library_MainViewEntryItem_DeepDive", package.seeall)

local V4a1_Library_MainViewEntryItem_DeepDive = class("V4a1_Library_MainViewEntryItem_DeepDive", V4a1_Library_MainViewEntryItemImpl)

function V4a1_Library_MainViewEntryItem_DeepDive:onInitView()
	self._btnimage = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_image")
	self._golock = gohelper.findChild(self.viewGO, "root/#go_lock")
	self._txttime = gohelper.findChildText(self.viewGO, "root/time/#txt_time")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_Library_MainViewEntryItem_DeepDive:addEvents()
	self._btnimage:AddClickListener(self._btnimageOnClick, self)
end

function V4a1_Library_MainViewEntryItem_DeepDive:removeEvents()
	self._btnimage:RemoveClickListener()
end

function V4a1_Library_MainViewEntryItem_DeepDive:ctor(...)
	V4a1_Library_MainViewEntryItem_DeepDive.super.ctor(self, ...)
end

function V4a1_Library_MainViewEntryItem_DeepDive:onDestroyView()
	V4a1_Library_MainViewEntryItem_DeepDive.super.onDestroyView(self)
end

function V4a1_Library_MainViewEntryItem_DeepDive:_editableInitView()
	V4a1_Library_MainViewEntryItem_DeepDive.super._editableInitView(self)
end

function V4a1_Library_MainViewEntryItem_DeepDive:_editableAddEvents()
	V4a1_Library_MainViewEntryItem_DeepDive.super._editableAddEvents(self)
end

function V4a1_Library_MainViewEntryItem_DeepDive:_editableRemoveEvents()
	V4a1_Library_MainViewEntryItem_DeepDive.super._editableRemoveEvents(self)
end

function V4a1_Library_MainViewEntryItem_DeepDive:setData(mo)
	V4a1_Library_MainViewEntryItem_DeepDive.super.setData(self, mo)
end

return V4a1_Library_MainViewEntryItem_DeepDive
