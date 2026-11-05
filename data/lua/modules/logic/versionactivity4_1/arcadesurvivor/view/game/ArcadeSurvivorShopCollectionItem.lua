-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorShopCollectionItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorShopCollectionItem", package.seeall)

local ArcadeSurvivorShopCollectionItem = class("ArcadeSurvivorShopCollectionItem", LuaCompBase)

function ArcadeSurvivorShopCollectionItem:init(go)
	self.go = go
	self._imagequalitybg = gohelper.findChildImage(self.go, "#image_qualitybg")
	self._imageframebg = gohelper.findChildImage(self.go, "#go_collection/bg")
	self._simageicon = gohelper.findChildSingleImage(self.go, "#go_collection/#image_icon")
	self._txtname = gohelper.findChildText(self.go, "#txt_Name")
	self._gotags = gohelper.findChild(self.go, "#go_tags")
	self._gotagitem = gohelper.findChild(self.go, "#go_tags/#go_item")
	self._txtdesc = gohelper.findChildText(self.go, "#txt_Scroll/Viewport/content/#txt_Desc")
	self._goprice = gohelper.findChild(self.go, "txt_numbg")
	self._txtprice = gohelper.findChildText(self.go, "txt_numbg/#txt_num")
	self._imageCost = gohelper.findChildImage(self.go, "txt_numbg/#txt_num/#image_icon")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._gorecommend = gohelper.findChild(self.go, "#go_recommend")
	self._golock = gohelper.findChild(self.go, "#go_lock")
	self._btnlock = gohelper.findChildClickWithAudio(self.go, "#go_lock/#btn_click", AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_product_lock)
	self._gounlock = gohelper.findChild(self.go, "#go_unlock")
	self._btnunlock = gohelper.findChildClickWithAudio(self.go, "#go_unlock/#btn_click", AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_product_lock)
	self._gorefresh = gohelper.findChild(self.go, "#go_refresh")
	self._btnrefresh = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.go, "#go_refresh/#btn_refresh")
	self._txtrefreshnum = gohelper.findChildText(self.go, "#go_refresh/#btn_refresh/#txt_num")
	self._btnClick = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorShopCollectionItem:addEventListeners()
	self._btnlock:AddClickListener(self._setIsLock, self, false)
	self._btnunlock:AddClickListener(self._setIsLock, self, true)
	self._btnClick:AddClickListener(self._btnclickOnClick, self)
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
end

function ArcadeSurvivorShopCollectionItem:removeEventListeners()
	self._btnlock:RemoveClickListener()
	self._btnunlock:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnrefresh:RemoveClickListener()
end

function ArcadeSurvivorShopCollectionItem:_setIsLock(isLock)
	if self._packId then
		return
	end

	local id = self:getId()

	ArcadeSurvivorGameController.instance:setGoodsIsLock(ArcadeSurvivorGameEnum.ShopGoodsType.Collection, id, isLock, self._index)
	gohelper.setActive(self._golock, isLock)
	gohelper.setActive(self._gounlock, not isLock)

	if self._parentView then
		self._parentView:refreshBtnRefresh()
	end
end

function ArcadeSurvivorShopCollectionItem:_btnclickOnClick()
	local id = self:getId()

	if self._isRerolling or not self._parentView or not id then
		return
	end

	if self._packId then
		self._parentView:onSelectChoice(self._index)
	else
		self._parentView:onSelectGoods(self._index)
	end
end

function ArcadeSurvivorShopCollectionItem:_btnrefreshOnClick()
	if self._isRerolling or not self._packId then
		return
	end

	local rerollCount = ArcadeSurvivorConfig.instance:getPackRerollCount(self._packId)

	if rerollCount <= self._consumePackRerollCount then
		return
	end

	local newId = self._parentView:getRerollCollectionId()

	if not newId then
		return
	end

	self._isRerolling = true
	self._consumePackRerollCount = self._consumePackRerollCount + 1
	self._id = newId

	self:_playCloseAnim(self._afterRerollCloseAnim, self)
end

function ArcadeSurvivorShopCollectionItem:_afterRerollCloseAnim()
	self._isRerolling = false

	self:refreshItem()
	self:playOpenAnim()
	self:refreshRerollBtn()
end

function ArcadeSurvivorShopCollectionItem:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.go)
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))
	self._canvasGroup = gohelper.onceAddComponent(self.go, typeof(UnityEngine.CanvasGroup))

	self:onSelect(false)
end

function ArcadeSurvivorShopCollectionItem:onUpdateMO(id, index, parentView, packId, isLock, lockNeedPlayOpen)
	self._canvasGroup.alpha = 1
	self._canvasGroup.interactable = true
	self._canvasGroup.blocksRaycasts = true
	self._id = id
	self._parentView = parentView
	self._index = index
	self._packId = packId
	self._alreadyBuy = nil
	self._alreadyChoice = nil
	self._consumePackRerollCount = 0
	self._isRerolling = false

	self:refreshItem()

	if self._packId then
		gohelper.setActive(self._golock, false)
		gohelper.setActive(self._gounlock, false)
		self:refreshRerollBtn()
	else
		self:_setIsLock(isLock)
		self:refreshCanBuy()
	end

	gohelper.setActive(self._goprice, not self._packId)
	gohelper.setActive(self._gorefresh, self._packId)

	if not isLock or lockNeedPlayOpen then
		self:playOpenAnim()
	else
		self._animator.enabled = true

		self._animator:Play(self._openAnim, 0, 1)
	end
end

function ArcadeSurvivorShopCollectionItem:refreshItem()
	local id = self:getId()

	self._txtname.text = ArcadeSurvivorConfig.instance:getCollectionName(id)
	self._txtdesc.text = ArcadeSurvivorConfig.instance:getCollectionDesc(id)
	self._openAnim = "open_normal"
	self._closeAnim = "close_normal"

	local rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(id)

	if rarity == ArcadeSurvivorGameEnum.Const.SPRarity then
		self._openAnim = "open_sp"
		self._closeAnim = "close_sp"
	end

	local displayRarity = ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
	local itembg = string.format(ArcadeSurvivorEnum.Const.ShopCollectionBg, displayRarity)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imagequalitybg, itembg)

	local framebg = string.format(ArcadeSurvivorEnum.Const.CollectionFrame, displayRarity)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageframebg, framebg)

	local icon = ArcadeSurvivorConfig.instance:getCollectionIcon(id)

	if not string.nilorempty(icon) then
		self._simageicon:LoadImage(ResUrl.getArcadeSurvivorIcon(icon))
	end

	self:refreshTag()
end

function ArcadeSurvivorShopCollectionItem:refreshTag()
	local id = self:getId()
	local isRecommend = false
	local tagList = ArcadeSurvivorConfig.instance:getCollectionTagIds(id) or {}
	local characterMO = ArcadeSurvivorGameModel.instance:getCharacterMO()

	if characterMO then
		for _, tag in ipairs(tagList) do
			local haveTag = characterMO:getHaveCollectionTag(tag)

			if haveTag then
				isRecommend = true

				break
			end
		end
	end

	gohelper.setActive(self._gorecommend, isRecommend)
	gohelper.CreateObjList(self, self._onCreateTagItem, tagList, self._gotags, self._gotagitem)
end

function ArcadeSurvivorShopCollectionItem:_onCreateTagItem(obj, data, index)
	local collectionId = self:getId()
	local rarity = ArcadeSurvivorConfig.instance:getCollectionRarity(collectionId)
	local displayRarity = ArcadeSurvivorHelper.getCollectionDisplayRarity(rarity)
	local tagbg = string.format(ArcadeSurvivorEnum.Const.CollectionTagRareBg, displayRarity)
	local imagebg = obj:GetComponent(gohelper.Type_Image)

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(imagebg, tagbg)

	local txt = gohelper.findChildText(obj, "#txt")

	txt.text = ArcadeSurvivorConfig.instance:getTagName(data)
end

function ArcadeSurvivorShopCollectionItem:refreshCanBuy()
	local collectionId = self:getId()
	local cost = ArcadeSurvivorGameModel.instance:getGoodsCost(ArcadeSurvivorGameEnum.ShopGoodsType.Collection, collectionId)
	local strPrice = GameUtil.numberDisplay(cost or 0)
	local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Collection, collectionId)

	if not canBuy then
		strPrice = string.format("<color=#FF0000>%s</color>", strPrice)
	end

	self._txtprice.text = strPrice

	self:refreshCostIcon()
end

function ArcadeSurvivorShopCollectionItem:refreshCostIcon()
	local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()
	local hpPerCoin = ruleModel:getCoinPerHp() or 0
	local costIcon = "v4a1_eliminate_currency2_2"

	if hpPerCoin > 0 then
		costIcon = "v4a1_eliminate_heart_2"
	end

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageCost, costIcon, true)
end

function ArcadeSurvivorShopCollectionItem:refreshRerollBtn()
	local rerollCount = ArcadeSurvivorConfig.instance:getPackRerollCount(self._packId)
	local remainCount = math.max(0, rerollCount - self._consumePackRerollCount)

	self._txtrefreshnum.text = remainCount

	ZProj.UGUIHelper.SetGrayscale(self._btnrefresh.gameObject, remainCount <= 0)
end

function ArcadeSurvivorShopCollectionItem:playAnim(animName, cb, cbObj)
	if not self._animPlayer or string.nilorempty(animName) then
		return
	end

	self._animPlayer:Play(animName, cb, cbObj)
end

function ArcadeSurvivorShopCollectionItem:playOpenAnim()
	gohelper.setActive(self.go, true)
	self:playAnim(self._openAnim)
end

function ArcadeSurvivorShopCollectionItem:_playCloseAnim(cb, cbObj)
	if cb and cbObj then
		self:playAnim(self._closeAnim, cb, cbObj)
	else
		self:playAnim(self._closeAnim, self._afterCloseAnim, self)
	end
end

function ArcadeSurvivorShopCollectionItem:_afterCloseAnim()
	gohelper.setActive(self.go, false)
end

function ArcadeSurvivorShopCollectionItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function ArcadeSurvivorShopCollectionItem:onChoice()
	if self._isRerolling then
		return
	end

	local id = self:getId()
	local result = ArcadeSurvivorGameController.instance:gainCollection(id)

	if result then
		self._alreadyChoice = true

		UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.ChoicePackCollection)
		self:_playCloseAnim(self._afterChoiceCloseAnim, self)

		return true
	end
end

function ArcadeSurvivorShopCollectionItem:_afterChoiceCloseAnim()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ChoicePackCollection)
	gohelper.setActive(self.go, false)
	self._parentView:checkNextChoice()
end

function ArcadeSurvivorShopCollectionItem:onBuy()
	if self._alreadyBuy then
		return
	end

	local id = self:getId()

	if not id then
		return
	end

	local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Collection, id)

	if not canBuy then
		return
	end

	UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.ShopOnBuy)

	self._alreadyBuy = true

	self:_playCloseAnim(self._afterBuyCloseAnim, self)

	return true
end

function ArcadeSurvivorShopCollectionItem:_afterBuyCloseAnim()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ShopOnBuy)

	local id = self:getId()
	local result = ArcadeSurvivorGameController.instance:buyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Collection, id)

	if result then
		self._canvasGroup.alpha = 0
		self._canvasGroup.interactable = false
		self._canvasGroup.blocksRaycasts = false
	else
		self._alreadyBuy = nil

		self:playOpenAnim()
	end

	if self._parentView then
		self._parentView:refreshGoodsState()

		if result then
			self._parentView:selectNextCanBuyGoodsIndex()
		end
	end
end

function ArcadeSurvivorShopCollectionItem:getId()
	return self._id
end

function ArcadeSurvivorShopCollectionItem:getIsAlreadyBuy()
	return self._alreadyBuy
end

function ArcadeSurvivorShopCollectionItem:getIsAlreadyChoice()
	return self._alreadyChoice
end

function ArcadeSurvivorShopCollectionItem:getIsCanBuy()
	local alreadyBuy = self:getIsAlreadyBuy()

	if not alreadyBuy then
		local collectionId = self:getId()
		local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Collection, collectionId)

		return canBuy
	end
end

function ArcadeSurvivorShopCollectionItem:clear()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ChoicePackCollection)
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ShopOnBuy)

	self._id = nil
	self._parentView = nil
	self._index = nil
	self._packId = nil
	self._alreadyBuy = nil
	self._alreadyChoice = nil
	self._isRerolling = false

	self._simageicon:UnLoadImage()
	gohelper.setActive(self.go, false)
end

function ArcadeSurvivorShopCollectionItem:onDestroy()
	self:clear()
end

return ArcadeSurvivorShopCollectionItem
