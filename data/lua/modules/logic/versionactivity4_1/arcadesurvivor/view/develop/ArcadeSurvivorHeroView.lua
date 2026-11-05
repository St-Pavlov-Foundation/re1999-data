-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/develop/ArcadeSurvivorHeroView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.develop.ArcadeSurvivorHeroView", package.seeall)

local ArcadeSurvivorHeroView = class("ArcadeSurvivorHeroView", BaseView)

function ArcadeSurvivorHeroView:onInitView()
	self._gohero = gohelper.findChild(self.viewGO, "bottom/#go_hero")
	self._heroRoot = gohelper.findChild(self.viewGO, "bottom/#go_hero/scroll_hero/Viewport/Content")
	self._goheroitem = gohelper.findChild(self.viewGO, "bottom/#go_hero/#go_heroitem")
	self._btnselect = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "bottom/btn/#btn_select")
	self._gounlockTips = gohelper.findChild(self.viewGO, "bottom/btn/#go_unlockTips")
	self._txtunlockTips = gohelper.findChildText(self.viewGO, "bottom/btn/#go_unlockTips/#txt_unlockTips")
	self._goequiped = gohelper.findChild(self.viewGO, "bottom/btn/#go_equiped")
	self._goequipedEffect = gohelper.findChild(self.viewGO, "bottom/btn/#go_equiped/#effect")
	self._goinfo = gohelper.findChild(self.viewGO, "#go_info")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#go_info/role/#simage_bg")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "#go_info/role/node/#simage_role")
	self._imagerole = gohelper.findChildImage(self.viewGO, "#go_info/role/node/#simage_role")
	self._btnrole = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_info/role/node/#simage_role/#btn_role")
	self._goroleunlock = gohelper.findChild(self.viewGO, "#go_info/role/node")
	self._gorolelock = gohelper.findChild(self.viewGO, "#go_info/role/lock")
	self._gounlock = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/layout/#txt_name")
	self._gobase = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/layout/#go_base/go_baseitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/title/txt_title")
	self._scrolldes = gohelper.findChildScrollRect(self.viewGO, "#go_info/info/#go_unlock/#scroll_des")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/#scroll_des/viewport/content/#txt_Desc")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem")
	self._simagecollectionicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionicon = gohelper.findChildImage(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#image_icon")
	self._imagecollectionbg = gohelper.findChildImage(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/bg")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/#txt_num")
	self._btncollection = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_info/info/#go_unlock/skill/#go_collection/#go_collectionitem/btn_click")
	self._goweapon = gohelper.findChild(self.viewGO, "#go_info/info/#go_unlock/skill/#go_weapon")
	self._simageweaponicon = gohelper.findChildSingleImage(self.viewGO, "#go_info/info/#go_unlock/skill/#go_weapon/#image_icon")
	self._btnweapon = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "#go_info/info/#go_unlock/skill/#go_weapon/btn_click")
	self._goherolock = gohelper.findChild(self.viewGO, "#go_info/info/#go_lock")
	self._txtlockname = gohelper.findChildText(self.viewGO, "#go_info/info/#go_lock/layout/#txt_name")
	self._txtlock = gohelper.findChildText(self.viewGO, "#go_info/info/#go_lock/#txt_lock")
	self._txtlocktitle = gohelper.findChildText(self.viewGO, "#go_info/info/#go_lock/title/txt_title")
	self._golockattritem = gohelper.findChild(self.viewGO, "#go_info/info/#go_lock/layout/go_base/#go_lockbaseitem")
	self._gotips = gohelper.findChild(self.viewGO, "#go_info/info/skill/#go_tips")
	self._gotags = gohelper.findChild(self.viewGO, "#go_tags")
	self._gotagitem = gohelper.findChild(self.viewGO, "#go_tags/tagitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHeroView:addEvents()
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	self._btnweapon:AddClickListener(self._btnweaponOnClick, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnEquipHero, self._onEquipHero, self)
end

function ArcadeSurvivorHeroView:removeEvents()
	self._btnselect:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self._btnweapon:RemoveClickListener()
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnClickHeroItem, self._onClickSelectItem, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.OnEquipHero, self._onEquipHero, self)
end

function ArcadeSurvivorHeroView:_btnselectOnClick()
	local heroId = self._selectHeroMO:getId()

	ArcadeSurvivorHeroModel.instance:setEquipHeroId(heroId)
	ArcadeSurvivorRpc.instance:sendArcadeSurvivorSwitchCharacterRequest(heroId)
end

function ArcadeSurvivorHeroView:_btncollectionOnClick()
	if not self._collectionMO then
		local effectDict = self._selectHeroMO:getEffectDict()

		self._collectionMO = effectDict and effectDict[ArcadeSurvivorEnum.EffectType.Collection]

		if not self._collectionMO then
			return
		end
	end

	local anchor = {
		x = -88.9169,
		y = -342
	}
	local param = {
		collectionMO = self._collectionMO,
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Collection, param)
end

function ArcadeSurvivorHeroView:_btnweaponOnClick()
	if not self._weaponMO then
		return
	end

	local anchor = {
		x = 319.7169,
		y = 127.8
	}
	local characterId = self._selectHeroMO:getId()
	local param = {
		weaponMO = self._weaponMO,
		characterId = characterId,
		anchorPos = anchor,
		originalViewName = self.viewName
	}

	ArcadeSurvivorController.instance:openTipView(ArcadeSurvivorEnum.TipType.Weapon, param)
end

function ArcadeSurvivorHeroView:_onClickSelectItem()
	self._infoAnim:Play(UIAnimationName.Switch, 0, 0)
	self:_refreshHeroItem()
	TaskDispatcher.runDelay(self._refreshHeroInfo, self, 0.167)
	gohelper.setActive(self._goequipedEffect, false)
end

function ArcadeSurvivorHeroView:_onEquipHero()
	self:refreshView()
	gohelper.setActive(self._goequipedEffect, true)
	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_role_shangzhen)
end

function ArcadeSurvivorHeroView:_editableInitView()
	local equipId = ArcadeSurvivorHeroModel.instance:getEquipHeroId()

	ArcadeSurvivorHeroModel.instance:setSelectHeroId(equipId)
	gohelper.setActive(self._goheroitem, false)
	gohelper.setActive(self._gobase, false)
	gohelper.setActive(self._golockattritem, false)
	gohelper.setActive(self._gotagitem, false)

	self._attrItemDict = self:getUserDataTb_()
	self._lockAttrIconDict = self:getUserDataTb_()

	local desc = ArcadeSurvivorConfig.instance:getHandbookCategoryTitle(ArcadeSurvivorHallEnum.HandBookType.Character)

	self._txttitle.text = desc
	self._txtlocktitle.text = desc
	self._infoAnim = self._goinfo:GetComponent(typeof(UnityEngine.Animator))
	self._anim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goequipedEffect, false)
end

function ArcadeSurvivorHeroView:onUpdateParam()
	return
end

function ArcadeSurvivorHeroView:onOpen()
	self:refreshView()
end

function ArcadeSurvivorHeroView:onTabSwitchOpen()
	TaskDispatcher.cancelTask(self._refreshHeroInfo, self)
	self._anim:Play("open1", 0, 0)
	TaskDispatcher.runDelay(self._onFinishPlayOpenAnim, self, 0.333)
end

function ArcadeSurvivorHeroView:_onFinishPlayOpenAnim()
	ArcadeSurvivorController.instance:dispatchEvent(ArcadeSurvivorEvent.onFinishPlayOpenAnimHeroView)
end

function ArcadeSurvivorHeroView:refreshView()
	self:_refreshHeroItem()
	self:_refreshHeroInfo()
end

function ArcadeSurvivorHeroView:_refreshHeroItem()
	local selectId = ArcadeSurvivorHeroModel.instance:getSelectHeroId()

	self._selectHeroMO = ArcadeSurvivorHeroModel.instance:getHeroMOById(selectId)

	local moList = ArcadeSurvivorHeroModel.instance:getHeroMOList()

	gohelper.CreateObjList(self, self._createHeroItem, moList, self._heroRoot, self._goheroitem, ArcadeSurvivorHeroItem)
end

function ArcadeSurvivorHeroView:_createHeroItem(obj, data, index)
	obj:onUpdateMO(data)
	gohelper.setActive(obj.viewGO, true)
end

function ArcadeSurvivorHeroView:_refreshHeroInfo()
	self._isLock = self._selectHeroMO:isLock()

	gohelper.setActive(self._goherolock, self._isLock)
	gohelper.setActive(self._gorolelock, self._isLock)
	gohelper.setActive(self._gounlock, not self._isLock)
	gohelper.setActive(self._goroleunlock.gameObject, not self._isLock)

	if not self._isLock then
		local icon = self._selectHeroMO.handbookMO:getBigIcon()

		if not string.nilorempty(icon) then
			self._simagerole:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
		end

		local co = self._selectHeroMO.handbookMO:getCfg()
		local offset = {
			0,
			0
		}

		if co and co.icon2Offset2 then
			offset[1] = co.icon2Offset2[1] and tonumber(co.icon2Offset2[1]) or 0
			offset[2] = co.icon2Offset2[2] and tonumber(co.icon2Offset2[2]) or 0
		end

		recthelper.setAnchor(self._simagerole.transform, offset[1], offset[2])
	end

	self:_refreshInfo()
	self:_refreshBtn()
	self:_refreshTags()
end

function ArcadeSurvivorHeroView:_refreshInfo()
	local handbookMO = self._selectHeroMO.handbookMO

	if self._isLock then
		local tipStr = handbookMO:getLockTip()

		self._txtlock.text = tipStr
		self._txtunlockTips.text = tipStr

		self:_refreshLockAttribute()
	else
		self._txtname.text = handbookMO:getName()
		self._txtDesc.text = handbookMO:getDesc()

		self:_refreshAttribute()
		self:_refreshEffect()
	end
end

function ArcadeSurvivorHeroView:_refreshLockAttribute()
	local handbookMO = self._selectHeroMO.handbookMO
	local lockShowAttrIdList = handbookMO:getLockShowAttrIdList()

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

function ArcadeSurvivorHeroView:_getLockAttributeItem(attrId)
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

function ArcadeSurvivorHeroView:_refreshAttribute()
	local attrDict = self._selectHeroMO:getAttributeDict()

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

			local sort = ArcadeSurvivorConfig.instance:getAttributeSort(attrId)

			gohelper.setSibling(item.go, sort)
			gohelper.setActive(item.go, true)
		end
	end
end

function ArcadeSurvivorHeroView:_getAttributeItem(attrId)
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

function ArcadeSurvivorHeroView:_refreshEffect()
	local effectDict = self._selectHeroMO:getEffectDict()

	self._collectionMO = effectDict and effectDict[ArcadeSurvivorEnum.EffectType.Collection]
	self._weaponMO = effectDict and effectDict[ArcadeSurvivorEnum.EffectType.Weapon]

	self:_refreshCollection()
	self:_refreshWeapon()
end

function ArcadeSurvivorHeroView:_refreshCollection()
	gohelper.setActive(self._gocollection, self._collectionMO)

	if not self._collectionMO then
		return
	end

	local rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(self._collectionMO:getId())
	local displayRarity = ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
	local itembg = string.format(ArcadeSurvivorEnum.Const.CollectionRareBg, displayRarity)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imagecollectionbg, itembg)

	local icon = self._collectionMO:getIcon()

	if not string.nilorempty(icon) then
		self._simagecollectionicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
	end
end

function ArcadeSurvivorHeroView:_refreshWeapon()
	gohelper.setActive(self._goweapon, self._weaponMO)

	if not self._weaponMO then
		return
	end

	local icon = self._weaponMO:getIcon()

	if not string.nilorempty(icon) then
		self._simageweaponicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
	end
end

function ArcadeSurvivorHeroView:_refreshTags()
	local cfg = self._selectHeroMO.handbookMO:getCfg()
	local charTag = cfg and cfg.charTag

	if self._isLock or string.nilorempty(charTag) then
		gohelper.setActive(self._gotags, false)

		return
	end

	local tagList = {}

	for _, tagId in ipairs(string.split(charTag, "#")) do
		if ArcadeSurvivorConfig.instance:getCharTagCfg(tagId) then
			table.insert(tagList, tagId)
		else
			logError(string.format("ArcadeSurvivorHeroView:_refreshTags error, charTag is invalid, heroId:%s tagId:%s", cfg.id, tagId))
		end
	end

	gohelper.setActive(self._gotags, #tagList > 0)

	if #tagList == 0 then
		return
	end

	gohelper.CreateObjList(self, self._createTagItem, tagList, self._gotags, self._gotagitem)
end

function ArcadeSurvivorHeroView:_createTagItem(obj, tagId, index)
	local txt = gohelper.findChildText(obj, "#txt")

	txt.text = ArcadeSurvivorConfig.instance:getCharTagName(tagId)
end

function ArcadeSurvivorHeroView:_refreshBtn()
	local isEquip = self._selectHeroMO:isEquip()

	gohelper.setActive(self._btnselect.gameObject, not self._isLock and not isEquip)
	gohelper.setActive(self._goequiped.gameObject, not self._isLock and isEquip)
	gohelper.setActive(self._gounlockTips.gameObject, self._isLock)
end

function ArcadeSurvivorHeroView:onClose()
	TaskDispatcher.cancelTask(self._refreshHeroInfo, self)
	TaskDispatcher.cancelTask(self._onFinishPlayOpenAnim, self)
end

function ArcadeSurvivorHeroView:onDestroyView()
	self._simagerole:UnLoadImage()
	self._simagecollectionicon:UnLoadImage()
	self._simageweaponicon:UnLoadImage()
end

return ArcadeSurvivorHeroView
