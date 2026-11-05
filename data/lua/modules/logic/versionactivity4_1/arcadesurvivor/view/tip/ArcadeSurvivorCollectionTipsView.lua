-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/tip/ArcadeSurvivorCollectionTipsView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.tip.ArcadeSurvivorCollectionTipsView", package.seeall)

local ArcadeSurvivorCollectionTipsView = class("ArcadeSurvivorCollectionTipsView", ArcadeSurvivorTipsChildViewBase)

function ArcadeSurvivorCollectionTipsView:init(go)
	self.viewGO = go
	self._gocontent = gohelper.findChild(self.viewGO, "collection/#scroll_collection/viewport/content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "collection/#scroll_collection/viewport/content/#go_collectionitem")
	self._txtdec = gohelper.findChildText(self._gocollectionitem, "txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorCollectionTipsView:addEventListeners()
	return
end

function ArcadeSurvivorCollectionTipsView:removeEventListeners()
	return
end

function ArcadeSurvivorCollectionTipsView:_editableInitView()
	ArcadeSurvivorCollectionTipsView.super._editableInitView(self)
	gohelper.setActive(self._gocollectionitem, false)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function ArcadeSurvivorCollectionTipsView:onUpdateMO(mo, tipview)
	self._isInSide = mo.isInSide
	self._showNewCollection = false

	if self._isInSide then
		if not self._collectionList then
			self._showNewCollection = true
		end

		self._collectionList = mo and mo.collectionList or {}
	else
		if not self._collectionMO or mo.collectionMO and self._collectionMO.id ~= mo.collectionMO.id then
			self._showNewCollection = true
		end

		self._collectionMO = mo.collectionMO
	end

	ArcadeSurvivorCollectionTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeSurvivorCollectionTipsView:isPlayOpenAnim()
	return self._showNewCollection or self._isChange
end

function ArcadeSurvivorCollectionTipsView:refreshView()
	if self._collectionItemList then
		for _, item in ipairs(self._collectionItemList) do
			gohelper.setActive(item.go, false)
		end
	end

	local collectionDataList = {}

	if self._isInSide then
		collectionDataList = self._collectionList
	else
		collectionDataList = {
			self._collectionMO
		}
	end

	for i, data in ipairs(collectionDataList) do
		local name = ""
		local desc = ""
		local icon
		local count = 1
		local rarity

		if self._isInSide then
			name = ArcadeSurvivorConfig.instance:getCollectionName(data)
			desc = ArcadeSurvivorConfig.instance:getCollectionDesc(data)
			icon = ArcadeSurvivorConfig.instance:getCollectionIcon(data)

			local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

			count = characterMO and characterMO:getCollectionCount(data) or 0
			rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(data)
		else
			name = data:getName()
			desc = data:getDesc()
			icon = data:getIcon()
			count = data:getCount()

			local id = data:getId()

			rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(id)
		end

		local item = self:getCollectionItem(i)

		item.txtname.text = name
		item.txtdec.text = desc
		item.txtnum.text = "*" .. count

		if not string.nilorempty(icon) then
			item.simgicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
		end

		local displayRarity = ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
		local itembg = string.format(ArcadeSurvivorEnum.Const.CollectionRareBg, displayRarity)

		UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imagebg, itembg)

		local tipbg = string.format("v4a1_eliminate_tips_bg%s", displayRarity)

		UISpriteSetMgr.instance:setArcadeSurvivorSprite(item.imagequalitybg, tipbg)
		gohelper.setActive(item.go, true)
	end
end

function ArcadeSurvivorCollectionTipsView:getCollectionItem(index)
	if not self._collectionItemList then
		self._collectionItemList = {}
	end

	local item = self._collectionItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._gocollectionitem, self._gocontent)
		item.txtname = gohelper.findChildText(item.go, "title/txt_name")
		item.txtnum = gohelper.findChildText(item.go, "title/txt_name/txt_num")
		item.txtdec = gohelper.findChildText(item.go, "txt_desc")
		item.simgicon = gohelper.findChildSingleImage(item.go, "title/simage_icon")
		item.imagebg = gohelper.findChildImage(item.go, "title/bg")
		item.imagequalitybg = gohelper.findChildImage(item.go, "#qualitybg")
		self._collectionItemList[index] = item
	end

	return item
end

function ArcadeSurvivorCollectionTipsView:setAnchor(mo, x, y)
	if not mo.isInSide then
		self._collectionMO = mo.collectionMO

		local height = GameUtil.getPreferredHeight(self._txtdec, self._collectionMO:getDesc())

		if height > 130 then
			y = y + height - 130
		end
	end

	recthelper.setAnchor(self.viewGO.transform, x, y)
end

function ArcadeSurvivorCollectionTipsView:onDestroy()
	if self._collectionItemList then
		for _, item in ipairs(self._collectionItemList) do
			item.simgicon:UnLoadImage()
		end
	end
end

return ArcadeSurvivorCollectionTipsView
