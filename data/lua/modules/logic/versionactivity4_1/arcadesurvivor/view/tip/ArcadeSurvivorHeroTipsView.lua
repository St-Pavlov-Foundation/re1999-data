-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorHeroTipsView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorHeroTipsView", package.seeall)

local ArcadeSurvivorHeroTipsView = class("ArcadeSurvivorHeroTipsView", ArcadeSurvivorTipsChildViewBase)

function ArcadeSurvivorHeroTipsView:init(go)
	self.viewGO = go
	self._txtname = gohelper.findChildText(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/layout/#txt_name")
	self._gohp = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/layout/#go_hp")
	self._gohpItem = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/layout/#go_hp/go_hpitem")
	self._gomonster = gohelper.findChildSingleImage(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/monster")
	self._simagemonstericon = gohelper.findChildSingleImage(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/monster/mask/simage_icon")
	self._simageheroicon = gohelper.findChildSingleImage(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/title/simage_icon")
	self._gobase = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/#go_base")
	self._gobaseitem = gohelper.findChild(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/#go_base/go_baseitem")
	self._txtdesc = gohelper.findChildText(self.viewGO, "hero/#scroll_hero/viewport/content/#go_heroitem/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorHeroTipsView:addEventListeners()
	return
end

function ArcadeSurvivorHeroTipsView:removeEventListeners()
	return
end

function ArcadeSurvivorHeroTipsView:_editableInitView()
	ArcadeSurvivorHeroTipsView.super._editableInitView(self)

	self._attrItemList = self:getUserDataTb_()
	self._attrLayout = self._gobase:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self._attrAlignment = self._attrLayout.childAlignment
	self._attrPaddingLeft = self._attrLayout.padding.left
	self._hpItemList = self:getUserDataTb_()

	gohelper.setActive(self._gobase, true)
	gohelper.setActive(self._gobaseitem, false)
	gohelper.setActive(self._gohpItem, false)
	gohelper.setActive(self._gomonster, false)
	gohelper.setActive(self._simageheroicon.gameObject, true)
end

function ArcadeSurvivorHeroTipsView:onUpdateMO(mo, tipview)
	self._isInSide = mo.isInSide
	self._showNewMonster = false

	if self._isInSide then
		if not self._entityType or self._entityType ~= mo.entityType or not self._uid or self._uid ~= mo.uid then
			self._showNewMonster = true
		end

		self._entityType = mo.entityType
		self._uid = mo.uid
		self._entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(self._entityType, self._uid)
	else
		if not self._heroMO or mo.heroMO and self._heroMO.id ~= mo.heroMO.id then
			self._showNewMonster = true
		end

		self._heroMO = mo.heroMO
	end

	ArcadeSurvivorHeroTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSurvivorHeroTipsView:isPlayOpenAnim()
	return self._showNewMonster or self._isChange
end

function ArcadeSurvivorHeroTipsView:refreshView()
	local name, desc, icon

	if self._isInSide then
		if self._entityMO then
			name = self._entityMO:getName()
			desc = self._entityMO:getDesc()
			icon = self._entityMO:getIcon()
		end
	else
		local handBookMO = self._heroMO and self._heroMO:getHandbookMO()

		if not handBookMO then
			return
		end

		name = handBookMO:getName()
		desc = handBookMO:getDesc()
		icon = handBookMO:getIcon()
	end

	self._txtname.text = name
	self._txtdesc.text = desc

	if string.nilorempty(icon) then
		gohelper.setActive(self._simageheroicon, false)
		gohelper.setActive(self._gomonster, false)
	else
		local isUseImg = false

		if self._isInSide then
			isUseImg = self._entityMO and self._entityMO:getTipIsUseImg()
		end

		local iconPath = ResUrl.getArcadeSurvivorIcon(icon)

		if isUseImg then
			self._simagemonstericon:LoadImage(iconPath, self.onLoadImgFinished, self)
		else
			self._simageheroicon:LoadImage(iconPath)
		end

		gohelper.setActive(self._gomonster, isUseImg)
		gohelper.setActive(self._simageheroicon, not isUseImg)
	end

	self:_refreshAttribute()
	self:_refreshHp()
end

function ArcadeSurvivorHeroTipsView:onLoadImgFinished()
	if not self._simagemonstericon then
		return
	end

	local trans = self._simagemonstericon.transform

	self._simagemonstericon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()

	local posArr = self._entityMO and self._entityMO:getImgOffsetArr()
	local posX = posArr and tonumber(posArr[1])
	local posY = posArr and tonumber(posArr[2])

	if posX and posY then
		transformhelper.setLocalPosXY(trans, posX, posY)
	end

	local scaleArr = self._entityMO and self._entityMO:getImgScaleArr()
	local scaleX = scaleArr and tonumber(scaleArr[1])
	local scaleY = scaleArr and tonumber(scaleArr[2])

	if posX and posY then
		transformhelper.setLocalScale(trans, scaleX, scaleY, 1)
	end
end

function ArcadeSurvivorHeroTipsView:_refreshHp()
	if self._isInSide then
		local curHp = self._entityMO:getHp()
		local hpCap = self._entityMO:getAttrValue(ArcadeSurvivorEnum.Attribute.hpCap) or 0
		local maxShowCount = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.MaxShowHpCount, true)
		local showHpCount = math.min(hpCap, maxShowCount)

		for i = 1, showHpCount do
			local item = self:_getHpItem(i)
			local heartIcon = ArcadeSurvivorGameHelper.getHeartIconName(curHp, showHpCount, i)

			if heartIcon then
				UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imgIcon, heartIcon)
				gohelper.setActive(item.golight, true)
			else
				gohelper.setActive(item.golight, false)
			end

			gohelper.setActive(item.go, true)
		end

		for i = showHpCount + 1, #self._hpItemList do
			local item = self._hpItemList[i]

			if item then
				gohelper.setActive(item.go, false)
			end
		end

		gohelper.setActive(self._gohp, true)
	else
		local handBookMO = self._heroMO:getHandbookMO()
		local attrDict = handBookMO and handBookMO:getAttributeDict()
		local hpCap = attrDict and attrDict[ArcadeSurvivorEnum.Attribute.hpCap] or 0
		local showHpCount = ArcadeSurvivorConfig.instance:getConst(ArcadeSurvivorEnum.ConstId.MaxShowHpCount, true)

		for i = 1, showHpCount do
			local item = self:_getHpItem(i)
			local heartIcon = ArcadeSurvivorGameHelper.getHeartIconName(hpCap, showHpCount, i)

			if heartIcon then
				UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imgIcon, heartIcon)
				gohelper.setActive(item.golight, true)
			else
				gohelper.setActive(item.golight, false)
			end

			gohelper.setActive(item.go, true)
		end
	end
end

function ArcadeSurvivorHeroTipsView:_getHpItem(index)
	local item = self._hpItemList[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gohpItem, "hp_" .. index)

		item.go = go
		item.imgIcon = gohelper.findChildImage(go, "light")
		item.golight = gohelper.findChild(go, "light")
		self._hpItemList[index] = item
	end

	return item
end

function ArcadeSurvivorHeroTipsView:_refreshAttribute()
	local isMonster = self._isInSide and self._entityType == ArcadeSurvivorEnum.EntityType.Monster

	self._attrLayout.childAlignment = isMonster and UnityEngine.TextAnchor.MiddleCenter or self._attrAlignment
	self._attrLayout.padding.left = isMonster and self._attrLayout.padding.right or self._attrPaddingLeft

	if self._isInSide then
		local showAttrList = {
			ArcadeSurvivorEnum.Attribute.atk
		}

		if not isMonster then
			table.insert(showAttrList, ArcadeSurvivorEnum.Attribute.dodgeRate)
		end

		if self._entityType == ArcadeSurvivorEnum.EntityType.Character then
			table.insert(showAttrList, ArcadeSurvivorEnum.Attribute.respawnTimes)
		end

		gohelper.CreateObjList(self, self._onCreateAttrItem, showAttrList, self._gobase, self._gobaseitem)
		gohelper.setActive(self._gobase, true)
	else
		local attrDict = self._heroMO:getAttributeDict()

		for type, item in pairs(self._attrItemList) do
			local isShow = attrDict and attrDict[type]

			gohelper.setActive(item.go, isShow)
		end

		if attrDict then
			for attrId, attrValue in pairs(attrDict) do
				local item = self:_getAttributeItem(attrId)
				local showValue = ArcadeSurvivorHelper.getAttributeShowValue(attrId, attrValue)

				item.txtNum.text = showValue

				local icon = ArcadeSurvivorConfig.instance:getAttributeIcon(attrId)

				UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imgIcon, icon, true)

				local sort = ArcadeSurvivorConfig.instance:getAttributeSort(attrId)

				gohelper.setSibling(item.go, sort)
				gohelper.setActive(item.go, true)
			end
		end
	end
end

function ArcadeSurvivorHeroTipsView:_onCreateAttrItem(obj, data, index)
	local id = data
	local imagebase = gohelper.findChildImage(obj, "#image_base")
	local icon = ArcadeSurvivorConfig.instance:getAttributeIcon(id)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(imagebase, icon, true)

	local value = 0
	local txtNum = gohelper.findChildText(obj, "#txt_num")

	if self._entityMO then
		if id == ArcadeSurvivorEnum.Attribute.hp then
			value = self._entityMO:getHp()
		else
			value = self._entityMO:getAttrValue(id)
		end
	end

	txtNum.text = ArcadeSurvivorHelper.getAttributeShowValue(id, value)
end

function ArcadeSurvivorHeroTipsView:_getAttributeItem(type)
	local item = self._attrItemList[type]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._gobaseitem, "attr_" .. type)

		item.go = go
		item.txtNum = gohelper.findChildText(go, "#txt_num")
		item.imgIcon = gohelper.findChildImage(go, "#image_base")
		self._attrItemList[type] = item
	end

	return item
end

function ArcadeSurvivorHeroTipsView:onDestroy()
	self._simageheroicon:UnLoadImage()
	self._simagemonstericon:UnLoadImage()
end

return ArcadeSurvivorHeroTipsView
