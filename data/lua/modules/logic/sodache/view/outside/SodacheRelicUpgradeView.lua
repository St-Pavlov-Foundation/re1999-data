-- chunkname: @modules/logic/sodache/view/outside/SodacheRelicUpgradeView.lua

module("modules.logic.sodache.view.outside.SodacheRelicUpgradeView", package.seeall)

local SodacheRelicUpgradeView = class("SodacheRelicUpgradeView", BaseView)

function SodacheRelicUpgradeView:onInitView()
	self._goLeft = gohelper.findChild(self.viewGO, "#go_Left")
	self._goCardBG = gohelper.findChild(self.viewGO, "Right/Card/#go_CardBG")
	self._goCardItem = gohelper.findChild(self.viewGO, "Right/Card/#go_CardItem")
	self._goCost = gohelper.findChild(self.viewGO, "Right/Bottom/#go_Cost")
	self._goCardSimple = gohelper.findChild(self.viewGO, "Right/Bottom/#go_Cost/#go_CardSimple")
	self._txtCardCost = gohelper.findChildText(self.viewGO, "Right/Bottom/#go_Cost/#txt_CardCost")
	self._btnUpgrade = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Bottom/#btn_Upgrade")
	self._goUpgradeGray = gohelper.findChild(self.viewGO, "Right/Bottom/#btn_Upgrade/#go_UpgradeGray")
	self._goCoin = gohelper.findChild(self.viewGO, "Right/Bottom/#btn_Upgrade/#go_Coin")
	self._txtCoinCost = gohelper.findChildText(self.viewGO, "Right/Bottom/#btn_Upgrade/#go_Coin/#txt_CoinCost")
	self._goMax = gohelper.findChild(self.viewGO, "Right/Bottom/#go_Max")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheRelicUpgradeView:addEvents()
	self._btnUpgrade:AddClickListener(self._btnUpgradeOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function SodacheRelicUpgradeView:removeEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function SodacheRelicUpgradeView:_btnUpgradeOnClick()
	if self.checkPass then
		SodacheOutsideRpc.instance:sendSodacheRelicUpgrade(self.data.id)
	end
end

function SodacheRelicUpgradeView:_btnLeftOnClick()
	if self.index > 1 then
		self.index = self.index - 1
		self.data = SodacheRelicMoListModel.instance:getByIndex(self.index)

		self:refreshUI()
	end
end

function SodacheRelicUpgradeView:_btnRightOnClick()
	if self.index < self.maxIndex then
		self.index = self.index + 1
		self.data = SodacheRelicMoListModel.instance:getByIndex(self.index)

		self:refreshUI()
	end
end

function SodacheRelicUpgradeView:_btnCloseOnClick()
	self:closeThis()
end

function SodacheRelicUpgradeView:_editableInitView()
	self.cardInfoLeft = MonoHelper.addNoUpdateLuaComOnceToGo(self._goLeft, SodacheCardInfoLeft)
	self.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCardItem, SodacheCardItem)

	self.cardItem:setNoNeedClick()
	self.cardItem:showInfo()

	self.cardSimple = MonoHelper.addNoUpdateLuaComOnceToGo(self._goCardSimple, SodacheCardItem)

	self.cardSimple:setNoNeedClick()
	self.cardSimple:showInfo()
end

function SodacheRelicUpgradeView:onOpen()
	self:addEventCb(SodacheController.instance, SodacheEvent.OnRelicUpgrade, self.onRelicUpgrade, self)

	self.data = self.viewParam.data
	self.index = self.viewParam.index
	self.maxIndex = SodacheRelicMoListModel.instance:getCount()

	self:refreshUI()
end

function SodacheRelicUpgradeView:refreshUI()
	self.relicCfgs = lua_sodache_upgrade.configDict[self.data.id]
	self.checkPass = false

	gohelper.setActive(self._btnLeft, self.index > 1)
	gohelper.setActive(self._btnRight, self.index < self.maxIndex)

	local isMax = self.data.level == self.data.maxLevel

	if not isMax then
		local canUp = true
		local nextCfg = self.relicCfgs[self.data.level + 1]
		local params = GameUtil.splitString2(nextCfg.cost, true, "&", ":")

		for k, param in ipairs(params) do
			local itemCnt = SodacheUtil.getItemCount(param[1])

			if k == 1 then
				local matchStr = itemCnt < param[2] and "<#9A3C27>%d</color>/%d" or "%d/%d"

				self._txtCardCost.text = string.format(matchStr, itemCnt, param[2])
			elseif k == 2 then
				local matchStr = itemCnt < param[2] and "<#9A3C27>%d</color>" or "-%d"

				self._txtCoinCost.text = string.format(matchStr, itemCnt)
			end

			if canUp and itemCnt < param[2] then
				canUp = false
			end
		end

		gohelper.setActive(self._goCoin, #params > 1)

		self.checkPass = canUp
	end

	gohelper.setActive(self._goMax, isMax)
	gohelper.setActive(self._btnUpgrade, not isMax)
	gohelper.setActive(self._goCost, not isMax)
	gohelper.setActive(self._goUpgradeGray, not self.checkPass)
	gohelper.setActive(self._goCardBG, isMax)

	local cardMo = SodacheCardMo.Create(self.data.itemCo.id)

	self.cardInfoLeft:setData(cardMo)
	self.cardItem:updateMo(cardMo)
	self.cardSimple:updateMo(cardMo)
end

function SodacheRelicUpgradeView:onRelicUpgrade(relicMo)
	self.cardInfoLeft:playRelicEffect(relicMo.level)
	self:refreshUI()
end

return SodacheRelicUpgradeView
