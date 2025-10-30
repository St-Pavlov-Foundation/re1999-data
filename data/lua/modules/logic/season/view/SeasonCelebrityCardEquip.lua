﻿-- chunkname: @modules/logic/season/view/SeasonCelebrityCardEquip.lua

module("modules.logic.season.view.SeasonCelebrityCardEquip", package.seeall)

local SeasonCelebrityCardEquip = class("SeasonCelebrityCardEquip", LuaCompBase)

function SeasonCelebrityCardEquip:init(go)
	SeasonCelebrityCardEquip.super.init(self, go)

	self.viewGO = go
	self._gorare5 = gohelper.findChild(self.viewGO, "#go_rare5")
	self._gorare4 = gohelper.findChild(self.viewGO, "#go_rare4")
	self._gorare3 = gohelper.findChild(self.viewGO, "#go_rare3")
	self._gorare2 = gohelper.findChild(self.viewGO, "#go_rare2")
	self._gorare1 = gohelper.findChild(self.viewGO, "#go_rare1")
	self._gobtnclick = gohelper.findChild(self.viewGO, "btn_click")
	self._gotag = gohelper.findChild(self.viewGO, "tag")
	self._gotype1 = gohelper.findChild(self.viewGO, "tag/#go_type1")
	self._imageType1 = gohelper.findChildImage(self.viewGO, "tag/#go_type1")
	self._gotype2 = gohelper.findChild(self.viewGO, "tag/#go_type2")
	self._gotype3 = gohelper.findChild(self.viewGO, "tag/#go_type3")
	self._gotype4 = gohelper.findChild(self.viewGO, "tag/#go_type4")

	if self._editableInitView then
		self:_editableInitView()
	end
end

SeasonCelebrityCardEquip.MaxRare = 5

function SeasonCelebrityCardEquip:_editableInitView()
	self._rareGoMap = {}

	for i = 1, SeasonCelebrityCardEquip.MaxRare do
		self._rareGoMap[i] = self:createRareMap(self["_gorare" .. tostring(i)])
	end

	self._darkMaskColor = "#ffffff"
	self._showTag = false
	self._showProbability = false
	self._showNewFlag = false
	self._showNewFlag2 = false
end

function SeasonCelebrityCardEquip:onDestroy()
	self:disposeUI()
end

function SeasonCelebrityCardEquip:checkInitBtnClick()
	if not self._btnclick then
		self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")

		self._btnclick:AddClickListener(self.onClickCall, self)
	end
end

function SeasonCelebrityCardEquip:checkInitLongPress()
	if not self._btnClickLongPrees then
		self._btnClickLongPrees = SLFramework.UGUI.UILongPressListener.Get(self._gobtnclick)

		self._btnClickLongPrees:AddLongPressListener(self.onLongPressCall, self)
	end
end

function SeasonCelebrityCardEquip:disposeUI()
	if not self._isDisposed then
		for _, item in pairs(self._rareGoMap) do
			if not gohelper.isNil(item.simageIcon) then
				item.simageIcon:UnLoadImage()
			end

			if not gohelper.isNil(item.simageSignature) then
				item.simageSignature:UnLoadImage()
			end
		end

		if self._btnClickLongPrees then
			self._btnClickLongPrees:RemoveLongPressListener()

			self._btnClickLongPrees = nil
		end

		if self._btnclick then
			self._btnclick:RemoveClickListener()

			self._btnclick = nil
		end

		self._isDisposed = true
	end
end

function SeasonCelebrityCardEquip:updateData(itemId)
	self.itemId = itemId

	self:refreshUI()
end

function SeasonCelebrityCardEquip:createRareMap(go)
	local viewItem = self:getUserDataTb_()

	viewItem.go = go
	viewItem.goSelfChoice = gohelper.findChild(go, "#go_rare6")
	viewItem.imageCareer = gohelper.findChildImage(go, "image_career")
	viewItem.simageIcon = gohelper.findChildSingleImage(go, "mask/image_icon")
	viewItem.simageSignature = gohelper.findChildSingleImage(go, "simage_signature")
	viewItem.imageIcon = gohelper.findChildImage(go, "mask/image_icon")
	viewItem.imageSignature = gohelper.findChildImage(go, "simage_signature")
	viewItem.imageBg = gohelper.findChildImage(go, "bg")
	viewItem.goSelfChoice = gohelper.findChild(go, "go_selfchoice")
	viewItem.imageDecorate = gohelper.findChildImage(go, "icon")

	return viewItem
end

function SeasonCelebrityCardEquip:refreshUI()
	if not self.itemId then
		return
	end

	local cfg = SeasonConfig.instance:getSeasonEquipCo(self.itemId)

	self._goCurSelected = nil
	self._cfg = cfg

	if not self._cfg then
		return
	end

	for rare, item in ipairs(self._rareGoMap) do
		local isCurRare = cfg.rare == rare

		gohelper.setActive(item.go, isCurRare)

		if isCurRare then
			self._curSelectedItem = item
		end
	end

	self:refreshSelfChoice()
	self:refreshIcon()
	self:refreshFlag()
end

function SeasonCelebrityCardEquip:refreshSelfChoice()
	if self._curSelectedItem then
		gohelper.setActive(self._curSelectedItem.goSelfChoice, SeasonConfig.instance:getEquipIsOptional(self.itemId))
	end
end

function SeasonCelebrityCardEquip:refreshIcon()
	if self._curSelectedItem then
		local item = self._curSelectedItem

		gohelper.setActive(item.goSelfChoice, self._cfg.isOptional == 1)

		if not string.nilorempty(self._cfg.careerIcon) then
			gohelper.setActive(item.imageCareer, true)
			UISpriteSetMgr.instance:setCommonSprite(item.imageCareer, self._cfg.careerIcon)
			SLFramework.UGUI.GuiHelper.SetColor(item.imageCareer, self._darkMaskColor)
		else
			gohelper.setActive(item.imageCareer, false)
		end

		if not string.nilorempty(self._cfg.icon) and item.simageIcon then
			gohelper.setActive(item.simageIcon, true)
			item.simageIcon:LoadImage(ResUrl.getSeasonCelebrityCard(self._cfg.icon), self.handleIconLoaded, self)
			SLFramework.UGUI.GuiHelper.SetColor(item.imageIcon, self._darkMaskColor)
		else
			gohelper.setActive(item.simageIcon, false)
		end

		if not string.nilorempty(self._cfg.signIcon) and item.simageSignature then
			gohelper.setActive(item.simageSignature, true)
			item.simageSignature:LoadImage(ResUrl.getSignature(self._cfg.signIcon, "characterget"))
		elseif self._cfg.rare ~= Activity104Enum.MainRoleRare then
			gohelper.setActive(item.simageSignature, false)
		end

		if item.imageSignature then
			SLFramework.UGUI.GuiHelper.SetColor(item.imageSignature, self._darkMaskColor)
		end

		if item.imageDecorate then
			SLFramework.UGUI.GuiHelper.SetColor(item.imageDecorate, self._darkMaskColor)
		end

		SLFramework.UGUI.GuiHelper.SetColor(item.imageBg, self._darkMaskColor)
		SeasonEquipMetaUtils.applyIconOffset(self.itemId, item.imageIcon, item.imageSignature)
	end
end

function SeasonCelebrityCardEquip:refreshFlag()
	if not self.itemId then
		return
	end

	local needShowType1 = self._showProbability and self._cfg.isOptional ~= 1
	local needShowType2 = self._showTag and self._cfg.isOptional == 1
	local needShowType3 = self._showNewFlag2 and not needShowType2
	local needShowType4 = self._showNewFlag and not needShowType2

	gohelper.setActive(self._gotag, needShowType1 or needShowType2 or needShowType3 or needShowType4)
	gohelper.setActive(self._gotype1, needShowType1)
	gohelper.setActive(self._gotype2, needShowType2)
	gohelper.setActive(self._gotype3, needShowType3)
	gohelper.setActive(self._gotype4, needShowType4)
end

function SeasonCelebrityCardEquip:setFlagUIPos(targetPosX, targetPosY)
	if not targetPosX or not targetPosY then
		return
	end

	recthelper.setAnchor(self._gotag.transform, targetPosX, targetPosY)
end

local defaultFlagUIScale = 2.3

function SeasonCelebrityCardEquip:setFlagUIScale(targetScale)
	targetScale = targetScale or defaultFlagUIScale

	transformhelper.setLocalScale(self._gotag.transform, targetScale, targetScale, targetScale)
end

function SeasonCelebrityCardEquip:handleIconLoaded()
	if not self._isDisposed then
		local item = self._curSelectedItem

		if item then
			gohelper.setActive(item.simageIcon, false)
			gohelper.setActive(item.simageIcon, true)
		end
	end
end

function SeasonCelebrityCardEquip:setColorDark(enable)
	self._darkMaskColor = enable and "#7b7b7b" or "#ffffff"

	self:refreshIcon()
end

function SeasonCelebrityCardEquip:setShowTag(enable)
	self._showTag = enable

	self:refreshFlag()
end

function SeasonCelebrityCardEquip:setShowProbability(enable)
	self._showProbability = enable

	self:refreshFlag()
end

function SeasonCelebrityCardEquip:setShowNewFlag(enable)
	self._showNewFlag = enable

	self:refreshFlag()
end

function SeasonCelebrityCardEquip:setShowNewFlag2(enable)
	self._showNewFlag2 = enable

	self:refreshFlag()
end

function SeasonCelebrityCardEquip:setClickCall(clickCall, clickCallObj, param)
	self._clickCallback = clickCall
	self._clickCallbackObj = clickCallObj
	self._clickParam = param

	if clickCall then
		self:checkInitBtnClick()
	end
end

function SeasonCelebrityCardEquip:setLongPressCall(longPressCall, longPressCallObj, param)
	self._longPressCallback = longPressCall
	self._longPressCallbackObj = longPressCallObj
	self._longPressParam = param

	if longPressCall then
		self:checkInitLongPress()
	end
end

function SeasonCelebrityCardEquip:onClickCall()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._clickParam)
	end
end

function SeasonCelebrityCardEquip:onLongPressCall()
	if self._longPressCallback then
		self._longPressCallback(self._longPressCallbackObj, self._longPressParam)
	end
end

return SeasonCelebrityCardEquip
