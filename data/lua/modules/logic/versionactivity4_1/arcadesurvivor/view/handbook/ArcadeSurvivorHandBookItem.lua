-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/handbook/ArcadeSurvivorHandBookItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.handbook.ArcadeSurvivorHandBookItem", package.seeall)

local ArcadeSurvivorHandBookItem = class("ArcadeSurvivorHandBookItem", ListScrollCellExtend)

function ArcadeSurvivorHandBookItem:onInitView()
	self._gounlock = gohelper.findChild(self.viewGO, "#go_unlock")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "#go_unlock/#simage_hero")
	self._imagehero = gohelper.findChildImage(self.viewGO, "#go_unlock/#simage_hero")
	self._goequiped = gohelper.findChild(self.viewGO, "#go_unlock/go_equiped")
	self._gohp = gohelper.findChild(self.viewGO, "#go_unlock/go_hp")
	self._golock = gohelper.findChild(self.viewGO, "#go_lock")
	self._simagelockhero = gohelper.findChildSingleImage(self.viewGO, "#go_lock/#simage_hero")
	self._imagelockhero = gohelper.findChildImage(self.viewGO, "#go_lock/#simage_hero")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btnclick = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#btn_click")
	self._gobg = gohelper.findChild(self.viewGO, "bg")
	self._goselectbg = gohelper.findChild(self.viewGO, "#go_select/bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHandBookItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeSurvivorHandBookItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ArcadeSurvivorHandBookItem:_btnclickOnClick()
	local showtype, showid = ArcadeSurvivorHandBookModel.instance:getShowCategoryType()
	local type, id = self._mo:getType(), self._mo:getId()

	if showtype == type and showid == id then
		return
	end

	ArcadeSurvivorHandBookModel.instance:setShowCategoryType(type, id)
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.OnClickHandBookItem, type, id)
end

function ArcadeSurvivorHandBookItem:_editableInitView()
	gohelper.setActive(self._gohp, false)
end

function ArcadeSurvivorHandBookItem:_editableAddEvents()
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self.onSelect, self)
end

function ArcadeSurvivorHandBookItem:_editableRemoveEvents()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self.onSelect, self)
end

function ArcadeSurvivorHandBookItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshView()
end

function ArcadeSurvivorHandBookItem:refreshView()
	self:_refreshStatus()

	local icon = self._mo:getIcon()

	if not string.nilorempty(icon) then
		self._simagehero:LoadImage(ResUrl.getArcadeSurvivorIcon(icon), function()
			self:_setNativeSize(self._imagehero)
		end, self)
		self._simagelockhero:LoadImage(ResUrl.getArcadeSurvivorIcon(icon), function()
			self:_setNativeSize(self._imagelockhero)
		end, self)
	end

	gohelper.setActive(self._goequiped, false)

	local sizeX, sizeY = self._mo:getIconSize()
	local anchorX, anchorY = self._mo:getAnchor()
	local itemParams = ArcadeSurvivorHallEnum.HandBookItemParams
	local rowCount, index = self._mo:getRowInfo()
	local offsetSizeX = 0
	local offsetAnchorX = 0

	if sizeX == itemParams.MinSize then
		offsetSizeX = itemParams.SpaceX

		if index == 1 then
			offsetAnchorX = offsetSizeX
		elseif index == 3 then
			offsetAnchorX = -offsetSizeX
		end
	elseif rowCount == 1 then
		offsetSizeX = itemParams.SpaceX * 3
	end

	sizeX = sizeX + itemParams.DiffX
	sizeY = sizeY + itemParams.DiffY

	recthelper.setAnchor(self.viewGO.transform, anchorX + (sizeX + offsetAnchorX) * 0.5, -anchorY - sizeY * 0.5)

	local _sizex = math.min(sizeX + offsetSizeX, itemParams.MaxWidth)

	recthelper.setSize(self.viewGO.transform, _sizex, sizeY)
	self:onSelect()
end

function ArcadeSurvivorHandBookItem:_setNativeSize(image)
	if not image then
		return
	end

	if self._mo:isSpecialIconSize() then
		local sizeX, sizeY = self._mo:getIconRectSize()

		recthelper.setSize(image.transform, sizeX, sizeY)
	else
		image:SetNativeSize()
	end
end

function ArcadeSurvivorHandBookItem:_refreshStatus()
	local isLock = self._mo:isLock()

	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._gounlock, not isLock)
	gohelper.setActive(self._goreddot, self._mo:isNew())
	gohelper.setActive(self._gobg, not isLock)
end

function ArcadeSurvivorHandBookItem:onSelect()
	local isSelect = self:_isSelect()

	gohelper.setActive(self._goselect, isSelect)

	if isSelect then
		gohelper.setAsLastSibling(self.viewGO)
		gohelper.setActive(self._goreddot, false)
	end

	local isLock = self._mo:isLock()

	if not isLock then
		local color = isSelect and Color.white or GameUtil.parseColor("#808080")

		self._imagehero.color = color
	end
end

function ArcadeSurvivorHandBookItem:_isSelect()
	local type, id = self._mo:getType(), self._mo:getId()
	local selecttype, selectid = ArcadeSurvivorHandBookModel.instance:getShowCategoryType()

	return type == selecttype and id == selectid
end

function ArcadeSurvivorHandBookItem:onDestroyView()
	self._simagehero:UnLoadImage()
	self._simagelockhero:UnLoadImage()
end

return ArcadeSurvivorHandBookItem
