-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/handbook/ArcadeSurvivorHandBookInfoView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.handbook.ArcadeSurvivorHandBookInfoView", package.seeall)

local ArcadeSurvivorHandBookInfoView = class("ArcadeSurvivorHandBookInfoView", BaseView)

function ArcadeSurvivorHandBookInfoView:onInitView()
	self._goinfo = gohelper.findChild(self.viewGO, "#go_view/root/#go_info")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/role/#simage_bg")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/role/node/#simage_role")
	self._imagerole = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/role/node/#simage_role")
	self._gounknownrole = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/role/node/unknown")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#txt_name")
	self._gobase = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#go_base/go_baseitem")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#go_base/go_baseitem/#txt_num")
	self._imagebase = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/layout/#go_base/go_baseitem/#txt_num/#image_base")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/title/txt_title")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/#scroll_des/viewport/content/#txt_Desc")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionicon = gohelper.findChildImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#txt_num")
	self._btncollection = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/btn_click")
	self._goweapon = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_weapon")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_weapon/#image_icon")
	self._btnweapon = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_view/root/#go_info/info/#go_unlock/skill/#go_weapon/btn_click")
	self._golock = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_lock")
	self._golockattritem = gohelper.findChild(self.viewGO, "#go_view/root/#go_info/info/#go_lock/layout/go_base/#go_lockbaseitem")
	self._txtlocktitle = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_lock/title/txt_title")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_view/root/#go_info/info/#go_lock/#txt_lock")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHandBookInfoView:addEvents()
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnweapon:AddClickListener(self._btnweaponOnClick, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeSurvivorHandBookInfoView:removeEvents()
	self._btncollection:RemoveClickListener()
	self._btnweapon:RemoveClickListener()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnCutHandBookTab, self._onCutHandBookTab, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHandBookItem, self._onClickHandBookItem, self)
end

function ArcadeSurvivorHandBookInfoView:_btncollectionOnClick()
	if not self._collectionMO then
		return
	end

	local anchor = {
		x = -72.1269,
		y = -645
	}
	local param = {
		collectionMO = self._collectionMO,
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Collection, param)
end

function ArcadeSurvivorHandBookInfoView:_btnweaponOnClick()
	if not self._weaponMO then
		return
	end

	local anchor = {
		x = 336.5069,
		y = -174.5491
	}
	local param = {
		weaponMO = self._weaponMO,
		characterId = self._mo:getId(),
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Weapon, param)
end

function ArcadeSurvivorHandBookInfoView:_onCutHandBookTab(type)
	TaskDispatcher.cancelTask(self.refreshView, self)
	self._anim:Play("open1", 0, 0)
	self:refreshView()
end

function ArcadeSurvivorHandBookInfoView:_onClickHandBookItem(type, id)
	self._infoAnim:Play(UIAnimationName.Switch, 0, 0)
	TaskDispatcher.runDelay(self.refreshView, self, 0.167)
end

function ArcadeSurvivorHandBookInfoView:_editableInitView()
	self._attrItemDict = self:getUserDataTb_()
	self._lockAttrIconDict = self:getUserDataTb_()

	gohelper.setActive(self._gobase, false)
	gohelper.setActive(self._golockattritem, false)

	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._infoAnim = self._goinfo:GetComponent(typeof(UnityEngine.Animator))
end

function ArcadeSurvivorHandBookInfoView:onUpdateParam()
	return
end

function ArcadeSurvivorHandBookInfoView:onOpen()
	TaskDispatcher.cancelTask(self.refreshView, self)
	self:refreshView()
end

function ArcadeSurvivorHandBookInfoView:refreshView()
	self._mo = ArcadeSurvivorHandBookModel.instance:getCurShowMO()

	local type = self._mo:getType()
	local desc = ArcadeSurvivorConfig.instance:getHandbookCategoryTitle(type)

	self._txttitle.text = desc
	self._txtlocktitle.text = desc

	self:_refreshStatus()
end

function ArcadeSurvivorHandBookInfoView:_refreshStatus()
	self._isLock = self._mo:isLock()

	gohelper.setActive(self._golock, self._isLock)
	gohelper.setActive(self._gounlock, not self._isLock)
	self:_refreshInfo()

	if self._isLock then
		local tipStr = self._mo:getLockTip()

		self._txtlock.text = tipStr

		self:_refreshLockAttribute()
	else
		self:_refreshAttribute()
		self:_refreshEffect()
	end
end

function ArcadeSurvivorHandBookInfoView:_refreshInfo()
	if not self._isLock then
		local icon = self._mo:getBigIcon()
		local hasIcon = string.nilorempty(icon)

		if not hasIcon then
			self._simagerole:LoadImage(ResUrl.getArcadeSurvivorIcon(icon), function()
				self._imagerole:SetNativeSize()
			end, self)
		end

		local anchorX, anchorY, scaleX, scaleY = self._mo:getBigIconTrans()

		recthelper.setAnchor(self._simagerole.transform, anchorX, anchorY)
		transformhelper.setLocalScale(self._simagerole.transform, scaleX, scaleY, 1)
	end

	self._txtname.text = self._mo:getName()

	self:_refreshSkillDesc()
	gohelper.setActive(self._gounknownrole.gameObject, self._isLock)
	gohelper.setActive(self._simagerole.gameObject, not self._isLock)
end

function ArcadeSurvivorHandBookInfoView:_refreshSkillDesc()
	local desc

	if self._isLock then
		desc = ArcadeSurvivorHallEnum.Const.Unknown
	else
		desc = self._mo:getDesc()

		local type = self._mo:getType()

		if type == ArcadeSurvivorHallEnum.HandBookType.Item then
			local characterId = ArcadeSurvivorConfig.instance:getCharacterIdByWeaponCollectionId(self._mo:getId())

			desc = ArcadeSurvivorHelper.getCollectionDescWithAttr(desc, characterId)
		end
	end

	self._txtDesc.text = desc
end

function ArcadeSurvivorHandBookInfoView:_refreshLockAttribute()
	local lockShowAttrIdList = self._mo:getLockShowAttrIdList()

	for attrId, item in pairs(self._lockAttrIconDict) do
		gohelper.setActive(item.go, false)
	end

	for _, attrId in ipairs(lockShowAttrIdList) do
		local item = self:_getLockAttributeItem(attrId)
		local icon = ArcadeSurvivorConfig.instance:getAttributeIcon(attrId)

		UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imgIcon, icon, true)

		local sort = ArcadeSurvivorConfig.instance:getAttributeSort(attrId)

		gohelper.setSibling(item.go, sort)
		gohelper.setActive(item.go, true)
	end
end

function ArcadeSurvivorHandBookInfoView:_getLockAttributeItem(attrId)
	local item = self._lockAttrIconDict[attrId]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._golockattritem, "lock_attr_" .. attrId)

		item.go = go
		item.imgIcon = gohelper.findChildImage(go, "icon")
		self._lockAttrIconDict[attrId] = item
	end

	return item
end

function ArcadeSurvivorHandBookInfoView:_refreshAttribute()
	local attrDict = self._mo:getAttributeDict()

	for attrId, item in pairs(self._attrItemDict) do
		local isShow = attrDict and attrDict[attrId]

		gohelper.setActive(item.go, isShow)
	end

	if attrDict then
		for attrId, attrValue in pairs(attrDict) do
			local item = self:_getAttributeItem(attrId)
			local showValue = ArcadeSurvivorHallEnum.Const.Unknown

			if not self._isLock then
				showValue = ArcadeSurvivorHelper.getAttributeShowValue(attrId, attrValue)
			end

			item.txtNum.text = showValue

			local icon = ArcadeSurvivorConfig.instance:getAttributeIcon(attrId)

			UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imgIcon, icon, true)
			gohelper.setActive(item.go, true)

			local sort = ArcadeSurvivorConfig.instance:getAttributeSort(attrId)

			gohelper.setSibling(item.go, sort)
		end
	end
end

function ArcadeSurvivorHandBookInfoView:_getAttributeItem(attrId)
	local item = self._attrItemDict[attrId]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gobase, "attr_" .. attrId)

		item.go = go
		item.txtNum = gohelper.findChildText(go, "#txt_num")
		item.imgIcon = gohelper.findChildImage(go, "#txt_num/#image_base")
		self._attrItemDict[attrId] = item
	end

	return item
end

function ArcadeSurvivorHandBookInfoView:_refreshEffect()
	local effectDict = self._mo:getEffectDict()

	self._collectionMO = effectDict and effectDict[ArcadeSurvivorEnum.EffectType.Collection]
	self._weaponMO = effectDict and effectDict[ArcadeSurvivorEnum.EffectType.Weapon]

	gohelper.setActive(self._gocollection, self._collectionMO)
	gohelper.setActive(self._goweapon, self._weaponMO)

	local height = effectDict and tabletool.len(effectDict) > 0 and 165 or 350

	recthelper.setHeight(self._scrolldes.transform, height)
	self:_refreshCollection()
	self:_refreshWeapon()
end

function ArcadeSurvivorHandBookInfoView:_refreshCollection()
	if not self._collectionMO then
		return
	end

	local icon = self._collectionMO:getIcon()

	if not string.nilorempty(icon) then
		local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

		self._simagecollectionicon:LoadImage(iconPath)
	end
end

function ArcadeSurvivorHandBookInfoView:_refreshWeapon()
	if not self._weaponMO then
		return
	end

	local icon = self._weaponMO:getIcon()

	if not string.nilorempty(icon) then
		local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

		self._simageweaponicon:LoadImage(iconPath)
	end
end

function ArcadeSurvivorHandBookInfoView:onClose()
	TaskDispatcher.cancelTask(self.refreshView, self)
end

function ArcadeSurvivorHandBookInfoView:onDestroyView()
	self._simagerole:UnLoadImage()
	self._simagecollectionicon:UnLoadImage()
	self._simageweaponicon:UnLoadImage()
end

return ArcadeSurvivorHandBookInfoView
