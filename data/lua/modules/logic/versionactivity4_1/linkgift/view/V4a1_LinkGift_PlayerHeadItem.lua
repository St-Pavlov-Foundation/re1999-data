-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_PlayerHeadItem.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_PlayerHeadItem", package.seeall)

local V4a1_LinkGift_PlayerHeadItem = class("V4a1_LinkGift_PlayerHeadItem", RougeSimpleItemBase)

function V4a1_LinkGift_PlayerHeadItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_PlayerHeadItem:addEvents()
	return
end

function V4a1_LinkGift_PlayerHeadItem:removeEvents()
	return
end

function V4a1_LinkGift_PlayerHeadItem:ctor(...)
	self:__onInit()
	V4a1_LinkGift_PlayerHeadItem.super.ctor(self, ...)
end

function V4a1_LinkGift_PlayerHeadItem:_btncheckOnClick()
	self:_onItemClick()
end

function V4a1_LinkGift_PlayerHeadItem:_editableInitView()
	V4a1_LinkGift_PlayerHeadItem.super._editableInitView(self)

	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self.viewGO)
end

function V4a1_LinkGift_PlayerHeadItem:bindName(txtCmp)
	self._pTxtname = txtCmp
end

function V4a1_LinkGift_PlayerHeadItem:setData(mo)
	V4a1_LinkGift_PlayerHeadItem.super.setData(self, mo)

	local itemType = mo[1]
	local itemId = mo[2]
	local itemCount = mo[3]
	local itemCO, iconResUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

	self._itemIcon:setMOValue(itemType, itemId, itemCount)
	self._itemIcon:isShowQuality(false)
	self._itemIcon:setCanShowDeadLine(false)
	self._itemIcon:isShowEquipAndItemCount(false)
	self._itemIcon:customOnClickCallback(self._onItemClick, self)

	if self._pTxtname then
		self._pTxtname.text = itemCO.name
	end
end

function V4a1_LinkGift_PlayerHeadItem:onDestroyView()
	self._pTxtname = nil
end

function V4a1_LinkGift_PlayerHeadItem:_onItemClick()
	local p = self:parent()

	if not p:onPlayerHeaddItemClick(self) then
		return
	end

	local mo = self._mo

	if not mo then
		return
	end

	local itemType = mo[1]
	local itemId = mo[2]

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

return V4a1_LinkGift_PlayerHeadItem
