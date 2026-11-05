-- chunkname: @modules/logic/versionactivity4_1/linkgift/view/V4a1_LinkGift_LayoutRewardItem.lua

module("modules.logic.versionactivity4_1.linkgift.view.V4a1_LinkGift_LayoutRewardItem", package.seeall)

local V4a1_LinkGift_LayoutRewardItem = class("V4a1_LinkGift_LayoutRewardItem", RougeSimpleItemBase)

function V4a1_LinkGift_LayoutRewardItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "#txt_num")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_check")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4a1_LinkGift_LayoutRewardItem:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function V4a1_LinkGift_LayoutRewardItem:removeEvents()
	self._btncheck:RemoveClickListener()
end

local COLOR_REWARD_GOT = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local COLOR_REWARD_NORMAL = Color.New(1, 1, 1, 1)
local COLOR_BG_GOT = Color.New(0.5, 0.5, 0.5, 1)
local COLOR_BG_NORMAL = Color.New(1, 1, 1, 1)

function V4a1_LinkGift_LayoutRewardItem:ctor(...)
	self:__onInit()
	V4a1_LinkGift_LayoutRewardItem.super.ctor(self, ...)
end

function V4a1_LinkGift_LayoutRewardItem:onDestroyView()
	self._pTxtname = nil

	V4a1_LinkGift_LayoutRewardItem.super.onDestroyView(self)
	self:__onDispose()
end

function V4a1_LinkGift_LayoutRewardItem:_btncheckOnClick()
	self:_onItemClick()
end

function V4a1_LinkGift_LayoutRewardItem:_editableInitView()
	V4a1_LinkGift_LayoutRewardItem.super._editableInitView(self)

	self._simageiconGo = self._simageicon.gameObject
	self._simageiconImg = self._simageiconGo:GetComponent(gohelper.Type_Image)
	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._simageiconGo)
	self._imagebg = gohelper.findChildImage(self.viewGO, "image_bg")
	self._imagebgGo = self._imagebg.gameObject
	self._goreceive = gohelper.findChild(self.viewGO, "go_receive")
	self._numbgGo = gohelper.findChild(self.viewGO, "numbg")
	self._txtnum.text = ""
end

function V4a1_LinkGift_LayoutRewardItem:_isClaimed()
	local p = self:parent()

	return p:isClaimedLayoutItem(self)
end

function V4a1_LinkGift_LayoutRewardItem:bindName(txtCmp)
	self._pTxtname = txtCmp
end

function V4a1_LinkGift_LayoutRewardItem:setData(mo)
	V4a1_LinkGift_LayoutRewardItem.super.setData(self, mo)

	local isClaimed = self:_isClaimed()
	local rewardColor = isClaimed and COLOR_REWARD_GOT or COLOR_REWARD_NORMAL
	local bgColor = isClaimed and COLOR_BG_GOT or COLOR_BG_NORMAL
	local itemType = mo[1]
	local itemId = mo[2]
	local itemCount = mo[3]
	local itemCO, iconResUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

	self._itemIcon:setMOValue(itemType, itemId, itemCount)
	self._itemIcon:isShowQuality(false)
	self._itemIcon:isShowEquipAndItemCount(false)
	self._itemIcon:customOnClickCallback(self._onItemClick, self)

	if self._itemIcon:isEquipIcon() then
		self._itemIcon:setScale(0.7)
	else
		self._itemIcon:setScale(0.8)
	end

	self:_setBg(itemCO.rare)

	local bShowNum = itemCount and itemCount > 1 and true or false

	gohelper.setActive(self._numbgGo, bShowNum)

	self._txtnum.text = bShowNum and luaLang("multiple") .. itemCount or ""
	self._simageiconImg.color = rewardColor
	self._imagebg.color = bgColor

	if self._pTxtname then
		self._pTxtname.text = itemCO.name
	end

	gohelper.setActive(self._goreceive, isClaimed)
end

function V4a1_LinkGift_LayoutRewardItem:_setBg(itemRare)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagebg, "bg_pinjidi_" .. tostring(itemRare or 0))
end

function V4a1_LinkGift_LayoutRewardItem:_onItemClick()
	local p = self:parent()

	if not p:onLayoutRewardItemClick(self) then
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

return V4a1_LinkGift_LayoutRewardItem
