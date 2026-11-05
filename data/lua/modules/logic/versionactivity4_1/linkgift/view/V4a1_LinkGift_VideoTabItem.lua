-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_VideoTabItem.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_VideoTabItem", package.seeall)

local V4a1_LinkGift_VideoTabItem = class("V4a1_LinkGift_VideoTabItem", RougeSimpleItemBase)

function V4a1_LinkGift_VideoTabItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_VideoTabItem:addEvents()
	return
end

function V4a1_LinkGift_VideoTabItem:removeEvents()
	return
end

function V4a1_LinkGift_VideoTabItem:ctor(...)
	V4a1_LinkGift_VideoTabItem.super.ctor(self, ...)
end

function V4a1_LinkGift_VideoTabItem:_btnvideo1OnClick()
	return
end

function V4a1_LinkGift_VideoTabItem:_editableInitView()
	V4a1_LinkGift_VideoTabItem.super._editableInitView(self)
	gohelper.setActive(self._goselect, false)
end

function V4a1_LinkGift_VideoTabItem:setData(mo)
	V4a1_LinkGift_VideoTabItem.super.setData(self, mo)
end

function V4a1_LinkGift_VideoTabItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function V4a1_LinkGift_VideoTabItem:onDestroyView()
	V4a1_LinkGift_VideoTabItem.super.onDestroyView(self)
end

return V4a1_LinkGift_VideoTabItem
