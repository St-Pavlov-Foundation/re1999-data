-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_TabItem.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_TabItem", package.seeall)

local V4a1_LinkGift_TabItem = class("V4a1_LinkGift_TabItem", RougeSimpleItemBase)

function V4a1_LinkGift_TabItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_TabItem:addEvents()
	return
end

function V4a1_LinkGift_TabItem:removeEvents()
	return
end

function V4a1_LinkGift_TabItem:ctor(...)
	V4a1_LinkGift_TabItem.super.ctor(self, ...)
end

function V4a1_LinkGift_TabItem:_editableAddEvents()
	if self._clickarea then
		self._clickarea:AddClickListener(self._clickareaOnClick, self)
	end
end

function V4a1_LinkGift_TabItem:_editableRemoveEvents()
	if self._clickarea then
		self._clickarea:RemoveClickListener()
	end
end

function V4a1_LinkGift_TabItem:_editableInitView()
	V4a1_LinkGift_TabItem.super._editableInitView(self)

	self._unselect = gohelper.findChild(self.viewGO, "unselect")
	self._selected = gohelper.findChild(self.viewGO, "selected")
	self._clickarea = gohelper.findChildButtonWithAudio(self.viewGO, "clickarea")

	gohelper.setActive(self._unselect, false)
	gohelper.setActive(self._selected, false)
end

function V4a1_LinkGift_TabItem:onDestroyView()
	V4a1_LinkGift_TabItem.super.onDestroyView(self)
end

function V4a1_LinkGift_TabItem:setData(mo)
	V4a1_LinkGift_TabItem.super.setData(self, mo)
end

function V4a1_LinkGift_TabItem:onSelect(isSelect)
	self:setActive_select(isSelect)
end

function V4a1_LinkGift_TabItem:setActive_select(isSelect)
	gohelper.setActive(self._selected, isSelect)
	gohelper.setActive(self._unselect, not isSelect)
end

function V4a1_LinkGift_TabItem:_clickareaOnClick()
	local p = self:parent()

	p:onClickTabItem(self)
end

return V4a1_LinkGift_TabItem
