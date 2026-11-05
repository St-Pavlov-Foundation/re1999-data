-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorShopPackItem.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorShopPackItem", package.seeall)

local ArcadeSurvivorShopPackItem = class("ArcadeSurvivorShopPackItem", LuaCompBase)

function ArcadeSurvivorShopPackItem:init(go)
	self.go = go
	self._imagecard = gohelper.findChildImage(self.go, "#simage_card")
	self._txtName = gohelper.findChildText(self.go, "#txt_Name")
	self._txtDesc = gohelper.findChildText(self.go, "txt_desc")
	self._txtprice = gohelper.findChildText(self.go, "#txt_num")
	self._imageCost = gohelper.findChildImage(self.go, "#txt_num/#image_icon")
	self._goselect = gohelper.findChild(self.go, "#go_select")
	self._btnClick = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.go, "#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorShopPackItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnclickOnClick, self)
end

function ArcadeSurvivorShopPackItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function ArcadeSurvivorShopPackItem:_btnclickOnClick()
	if self._parentView and self._id then
		self._parentView:onSelectGoods(self._index)
	end
end

function ArcadeSurvivorShopPackItem:_editableInitView()
	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.go)

	self:onSelect(false)
end

function ArcadeSurvivorShopPackItem:onUpdateMO(id, index, parentView)
	self._id = id
	self._parentView = parentView
	self._index = index
	self._alreadyBuy = nil
	self._price = ArcadeSurvivorConfig.instance:getPackPrice(id)
	self._openAnim = "open_normal"
	self._closeAnim = "close_normal"

	local rarity = ArcadeSurvivorConfig.instance:getPackRarity(id)

	if rarity == ArcadeSurvivorGameEnum.Const.SPRarity then
		self._openAnim = "open_sp"
		self._closeAnim = "close_sp"
	end

	self._txtName.text = ArcadeSurvivorConfig.instance:getPackName(id)
	self._txtDesc.text = ArcadeSurvivorConfig.instance:getPackDesc(id)

	local icon = ArcadeSurvivorConfig.instance:getPackIcon(id)

	if not string.nilorempty(icon) then
		UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imagecard, icon)
	end

	self:refreshCanBuy()
	self:playOpenAnim()
end

function ArcadeSurvivorShopPackItem:refreshCanBuy()
	local packId = self:getId()
	local goodsType = ArcadeSurvivorGameEnum.ShopGoodsType.Pack
	local cost = ArcadeSurvivorGameModel.instance:getGoodsCost(goodsType, packId)
	local strPrice = GameUtil.numberDisplay(cost or 0)
	local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(goodsType, packId)

	if not canBuy then
		strPrice = string.format("<color=#FF0000>%s</color>", strPrice)
	end

	self._txtprice.text = strPrice

	self:refreshCostIcon()
end

function ArcadeSurvivorShopPackItem:refreshCostIcon()
	local ruleModel = ArcadeSurvivorGameModel.instance:getRuleModel()
	local hpPerCoin = ruleModel:getCoinPerHp() or 0
	local costIcon = "v4a1_eliminate_currency2_2"

	if hpPerCoin > 0 then
		costIcon = "v4a1_eliminate_heart_2"
	end

	UISpriteSetMgr.instance:setArcadeSurvivorSprite(self._imageCost, costIcon, true)
end

function ArcadeSurvivorShopPackItem:playAnim(animName, cb, cbObj)
	if not self._animPlayer or string.nilorempty(animName) then
		return
	end

	self._animPlayer:Play(animName, cb, cbObj)
end

function ArcadeSurvivorShopPackItem:playOpenAnim()
	gohelper.setActive(self.go, true)
	self:playAnim(self._openAnim)
end

function ArcadeSurvivorShopPackItem:playBuyAnim()
	self:playAnim(self._closeAnim, self._afterBuyCloseAnim, self)
end

function ArcadeSurvivorShopPackItem:_afterBuyCloseAnim()
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ShopOnBuy)
	gohelper.setActive(self.go, false)

	local id = self:getId()
	local result = ArcadeSurvivorGameController.instance:buyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Pack, id)

	if not result then
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

function ArcadeSurvivorShopPackItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

function ArcadeSurvivorShopPackItem:onBuy()
	if self._alreadyBuy then
		return
	end

	local id = self:getId()
	local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Pack, id)

	if not canBuy then
		return
	end

	UIBlockMgr.instance:startBlock(ArcadeSurvivorEnum.BlockKey.ShopOnBuy)

	self._alreadyBuy = true

	self:playBuyAnim()

	return true
end

function ArcadeSurvivorShopPackItem:getId()
	return self._id
end

function ArcadeSurvivorShopPackItem:getIsAlreadyBuy()
	return self._alreadyBuy
end

function ArcadeSurvivorShopPackItem:getIsCanBuy()
	local alreadyBuy = self:getIsAlreadyBuy()

	if not alreadyBuy then
		local packId = self:getId()
		local canBuy = ArcadeSurvivorGameModel.instance:canBuyGoods(ArcadeSurvivorGameEnum.ShopGoodsType.Pack, packId)

		return canBuy
	end
end

function ArcadeSurvivorShopPackItem:clear()
	self._id = nil
	self._parentView = nil
	self._index = nil
	self._alreadyBuy = nil

	gohelper.setActive(self.go, false)
	UIBlockMgr.instance:endBlock(ArcadeSurvivorEnum.BlockKey.ShopOnBuy)
end

function ArcadeSurvivorShopPackItem:onDestroy()
	self:clear()
end

return ArcadeSurvivorShopPackItem
