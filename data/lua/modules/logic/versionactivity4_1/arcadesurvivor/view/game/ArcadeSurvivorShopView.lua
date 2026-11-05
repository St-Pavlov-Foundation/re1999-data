-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/view/game/ArcadeSurvivorShopView.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.view.game.ArcadeSurvivorShopView", package.seeall)

local ArcadeSurvivorShopView = class("ArcadeSurvivorShopView", BaseView)

function ArcadeSurvivorShopView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "root")
	self._goshop = gohelper.findChild(self.viewGO, "root/#go_shop")
	self._gobosstips = gohelper.findChild(self.viewGO, "root/#go_shop/#go_bosstips")
	self._gocollectionlist = gohelper.findChild(self.viewGO, "root/#go_shop/#go_collectionlist")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "root/#go_shop/#go_collectionlist/#go_collectionitem")
	self._gocardlist = gohelper.findChild(self.viewGO, "root/#go_shop/#go_cardlist")
	self._gocarditem = gohelper.findChild(self.viewGO, "root/#go_shop/#go_cardlist/#go_carditem")
	self._btnrefresh = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "root/#go_shop/btns/#btn_refresh")
	self._txtrefreshnum = gohelper.findChildText(self.viewGO, "root/#go_shop/btns/#btn_refresh/#txt_num")
	self._btnbuy = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "root/#go_shop/btns/#btn_buy")
	self._btnclose = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "root/#go_shop/#btn_close")
	self._gochoice = gohelper.findChild(self.viewGO, "root/#go_choice")
	self._btnselect = ArcadeSurvivorGameHelper.getArcadeSurvivorButton(self.viewGO, "root/#go_choice/btns/#btn_select")
	self._gochoicecollectionlist = gohelper.findChild(self.viewGO, "root/#go_choice/#go_collectionlist")
	self._gocurrency = gohelper.findChild(self.viewGO, "root/#go_currency")
	self._btnbattlefield = ArcadeSurvivorGameHelper.getArcadeSurvivorClickListener(self.viewGO, "root/#go_currency/#btn_battlefield")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeSurvivorShopView:addEvents()
	self._btnrefresh:AddClickListener(self._btnrefreshOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnselect:AddClickListener(self._btnselectOnClick, self)
	self._btnbattlefield:AddClickListener(self._btnbattlefieldOnClick, self)
	NavigateMgr.instance:addEscape(self.viewName, self._onBtnEsc, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnOpenPack, self._onOpenPack, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.BackToShopOrEventView, self._onBtnEsc, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCurrencyChange, self._onShopStateChange, self)
	self:addEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCollectionRuleChange, self._onShopStateChange, self)
	self:addEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.TipViewCloseBlurRefresh, self._onTipViewCloseBlurRefresh, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorShopView:removeEvents()
	self._btnrefresh:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnselect:RemoveClickListener()
	self._btnbattlefield:RemoveClickListener()
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnOpenPack, self._onOpenPack, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.BackToShopOrEventView, self._onBtnEsc, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnResetGame, self._onResetGame, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCurrencyChange, self._onShopStateChange, self)
	self:removeEventCb(ArcadeSurvivorGameController.instance, ArcadeSurvivorEvent.OnGameCollectionRuleChange, self._onShopStateChange, self)
	self:removeEventCb(ArcadeSurvivorController.instance, ArcadeSurvivorEvent.TipViewCloseBlurRefresh, self._onTipViewCloseBlurRefresh, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function ArcadeSurvivorShopView:_onTipViewCloseBlurRefresh(isBeforeClose)
	if not self._viewBattleField then
		return
	end

	if isBeforeClose then
		PostProcessingMgr.instance:setViewBlur(self.viewName, nil)
	else
		PostProcessingMgr.instance:setViewBlur(self.viewName, 0)
	end
end

function ArcadeSurvivorShopView:_btnrefreshOnClick()
	local haveRefreshCount = ArcadeSurvivorGameModel.instance:getShopRefreshCount()

	if haveRefreshCount <= self._consumeShopRefreshCount then
		return
	end

	local goodsCount = ArcadeSurvivorConfig.instance:getShopSlot(self._shopId)
	local lockGoodsIdList = ArcadeSurvivorGameModel.instance:getLockGoodsIdList(self._shopGoodsType)
	local lockCount = #lockGoodsIdList

	if goodsCount <= lockCount then
		return
	end

	self._consumeShopRefreshCount = self._consumeShopRefreshCount + 1

	self:clearGoodsItemList()
	self:setGoodsItemList()

	local goodsIdList = {}

	for i, item in ipairs(self._goodsItemList) do
		local goodsId = item:getId()

		goodsIdList[i] = goodsId
	end

	local goodsIdStr = table.concat(goodsIdList, "#")
	local strShopStatus = string.format("%s_%s_%s", self._shopId, self._consumeShopRefreshCount, goodsIdStr)

	ArcadeSurvivorGameController.instance:saveGame(strShopStatus, false)
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_yuanzheng_interface_open2)
	self:refreshBtnRefresh()
end

function ArcadeSurvivorShopView:_btnbuyOnClick()
	local goodsItem = self._goodsItemList and self._goodsItemList[self._selectedGoodsIndex]

	if goodsItem then
		local result = goodsItem:onBuy()

		if result then
			AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_product_buy)
			self._btnbuyanimator:Play(UIAnimationName.Click, 0, 0)
			self:refreshBtnRefresh()

			for _, item in ipairs(self._goodsItemList) do
				item:refreshCanBuy()
			end
		end
	end
end

function ArcadeSurvivorShopView:_btncloseOnClick()
	self:closeThis()
end

function ArcadeSurvivorShopView:_btnselectOnClick()
	local choiceItem = self._choiceItemList and self._choiceItemList[self._selectedChoiceIndex]

	if not choiceItem then
		return
	end

	local result = choiceItem:onChoice()

	if result then
		self._btnselectanimator:Play(UIAnimationName.Click, 0, 0)
		AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_atlantis_product_buy)
	end
end

function ArcadeSurvivorShopView:checkNextChoice()
	self._canChoiceCount = self._canChoiceCount - 1

	if self._canChoiceCount > 0 then
		self:selectNextCanChoiceIndex()

		return
	end

	self:clearChoiceItemList()

	if #self._waitOpenPackIdList > 0 then
		self:openChoicePanel()
	elseif self._shopId then
		gohelper.setActive(self._goshop, true)
		gohelper.setActive(self._gochoice, false)
		self:playAllGoodsItemOpenAnim()
		self:refreshBtnBuy()
	else
		self:closeThis()
	end
end

function ArcadeSurvivorShopView:_btnbattlefieldOnClick()
	if self._viewBattleField then
		return
	end

	self._viewBattleField = true

	gohelper.setActive(self._goRoot, false)
	PostProcessingMgr.instance:setViewBlur(self.viewName, 0)
end

function ArcadeSurvivorShopView:_onBtnEsc()
	if self._viewBattleField then
		self._viewBattleField = false

		PostProcessingMgr.instance:setViewBlur(self.viewName, nil)
		ArcadeSurvivorController.instance:closeTipView()
		gohelper.setActive(self._goRoot, true)
		self._animatorPlayer:Play(UIAnimationName.Open, nil, nil)

		if self._gochoice.activeSelf then
			if self._choiceItemList then
				for _, item in ipairs(self._choiceItemList) do
					if not item:getIsAlreadyChoice() then
						item:playOpenAnim()
					end
				end
			end
		else
			self:playAllGoodsItemOpenAnim()
		end

		self:refreshBtnBuy()
		self:refreshBtnRefresh()
	else
		self:_btnbattlefieldOnClick()
	end
end

function ArcadeSurvivorShopView:playAllGoodsItemOpenAnim()
	if self._goodsItemList then
		for _, item in ipairs(self._goodsItemList) do
			if not item:getIsAlreadyBuy() then
				item:playOpenAnim()
			end
		end
	end
end

function ArcadeSurvivorShopView:_onOpenPack(packId)
	if not packId then
		return
	end

	self._waitOpenPackIdList = self._waitOpenPackIdList or {}
	self._waitOpenPackIdList[#self._waitOpenPackIdList + 1] = packId

	if not self._choiceItemList then
		self:openChoicePanel()
	end
end

function ArcadeSurvivorShopView:_onResetGame()
	self._forceClose = true

	self:closeThis()
end

function ArcadeSurvivorShopView:_onCloseView(viewName)
	if viewName == ViewName.ArcadeSurvivorGameView then
		self._forceClose = true

		self:closeThis()
	end
end

function ArcadeSurvivorShopView:_editableInitView()
	self._txtShopTitle = gohelper.findChildText(self._goshop, "image_titlebg/#txt_title1")
	self._shopId = nil
	self._forceClose = nil
	self._consumeShopRefreshCount = 0
	self._waitOpenPackIdList = {}
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._btnbuyanimator = self._btnbuy:GetComponent(gohelper.Type_Animator)
	self._btnrefreshanimator = self._btnrefresh:GetComponent(gohelper.Type_Animator)
	self._btnselectanimator = self._btnselect:GetComponent(gohelper.Type_Animator)
end

function ArcadeSurvivorShopView:onUpdateParam(isOpening)
	if not self.viewParam then
		return
	end

	if isOpening or self.viewParam.shopId then
		self._isGMOpen = self.viewParam.isGMOpen
		self._shopId = self.viewParam.shopId
		self._savedGoodsIdList = self.viewParam.goodsIdList
		self._consumeShopRefreshCount = self.viewParam.consumeRefreshCount or 0
	end

	local newPackIdList = self.viewParam.newPackIdList

	if newPackIdList then
		for _, v in ipairs(newPackIdList) do
			self._waitOpenPackIdList[#self._waitOpenPackIdList + 1] = v
		end

		if not isOpening and not self._choiceItemList and #self._waitOpenPackIdList > 0 then
			self:openChoicePanel()
		end
	end
end

function ArcadeSurvivorShopView:onOpen()
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivor.play_ui_yuanzheng_interface_open)
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivorBgm.set_voice_volume_ui_8bit_music)
	self:onUpdateParam(true)

	if self._shopId then
		self._shopGoodsType = ArcadeSurvivorConfig.instance:getShopGoodsType(self._shopId)

		self:openShopPanel()
	elseif #self._waitOpenPackIdList > 0 then
		self:openChoicePanel()
	end
end

function ArcadeSurvivorShopView:onOpenFinish()
	if not self._goshop.activeSelf and not self._gochoice.activeSelf then
		logError("ArcadeSurvivorShopView:onOpenFinish error, both shop and choice panel are inactive")
		self:closeThis()
	end
end

function ArcadeSurvivorShopView:openShopPanel()
	local titleKey = self._shopGoodsType == ArcadeSurvivorGameEnum.ShopGoodsType.Pack and "p_arcade_survivorshopview_secret_title" or "p_arcade_survivorshopview_#txt_title1"

	self._txtShopTitle.text = luaLang(titleKey)

	local nextLevelId
	local curStageId = ArcadeSurvivorGameModel.instance:getCurStageId()
	local stageLevelCount = ArcadeSurvivorConfig.instance:getStageLevelCount(curStageId)
	local curLevelIndex = ArcadeSurvivorGameModel.instance:getCurLevelIndex()

	if stageLevelCount <= curLevelIndex then
		local curStageIndex = ArcadeSurvivorGameModel.instance:getCurStageIndex()
		local difficulty = ArcadeSurvivorGameModel.instance:getDifficulty()
		local nextStageId = ArcadeSurvivorConfig.instance:getDifficultyStageId(difficulty, curStageIndex + 1)

		nextLevelId = nextStageId and ArcadeSurvivorConfig.instance:getStageLevelId(nextStageId, 1)
	else
		nextLevelId = ArcadeSurvivorConfig.instance:getStageLevelId(curStageId, curLevelIndex + 1)
	end

	local nextIsBossLevel = nextLevelId and ArcadeSurvivorConfig.instance:getLevelIsBossLevel(nextLevelId)

	gohelper.setActive(self._gobosstips, nextIsBossLevel)
	gohelper.setActive(self._goshop, true)
	gohelper.setActive(self._gochoice, false)
	self:setGoodsItemList(true)
	self:refreshBtnRefresh()
end

function ArcadeSurvivorShopView:setGoodsItemList(onOpen)
	self._goodsItemList = {}

	local goodsIdList = {}

	if self._savedGoodsIdList and #self._savedGoodsIdList > 0 then
		goodsIdList = self._savedGoodsIdList
		self._savedGoodsIdList = nil
	else
		goodsIdList = ArcadeSurvivorGameModel.instance:getGoodsIdList(self._shopId)
	end

	if self._shopGoodsType == ArcadeSurvivorGameEnum.ShopGoodsType.Collection then
		gohelper.setActive(self._gocollectionlist, true)
		gohelper.setActive(self._gocardlist, false)

		local list = {}

		for index, collectionId in ipairs(goodsIdList) do
			local lockIndex = ArcadeSurvivorGameModel.instance:getIsLockGoods(self._shopGoodsType, collectionId)
			local isLock = lockIndex ~= nil
			local lockNeedPlayOpen = onOpen or isLock and index ~= lockIndex

			list[#list + 1] = {
				id = collectionId,
				isLock = isLock,
				lockNeedPlayOpen = lockNeedPlayOpen
			}
		end

		gohelper.CreateObjList(self, self._onCreateCollectionGoodsItem, list, self._gocollectionlist, self._gocollectionitem, ArcadeSurvivorShopCollectionItem)
		gohelper.setActive(self._btnrefresh, true)
	elseif self._shopGoodsType == ArcadeSurvivorGameEnum.ShopGoodsType.Pack then
		gohelper.setActive(self._gocollectionlist, false)
		gohelper.setActive(self._gocardlist, true)
		gohelper.CreateObjList(self, self._onCreatePackGoodsItem, goodsIdList, self._gocardlist, self._gocarditem, ArcadeSurvivorShopPackItem)
		gohelper.setActive(self._btnrefresh, false)
	else
		logError(string.format("ArcadeSurvivorShopView:openShopPanel shopGoodsType error %s", self._shopGoodsType))
	end

	self:selectNextCanBuyGoodsIndex()
end

function ArcadeSurvivorShopView:_onCreateCollectionGoodsItem(obj, data, index)
	local id = data.id
	local isLock = data.isLock
	local lockNeedPlayOpen = data.lockNeedPlayOpen

	obj:onUpdateMO(id, index, self, false, isLock, lockNeedPlayOpen)

	self._goodsItemList[index] = obj

	ArcadeSurvivorStatHelper.instance:recordCollectionAppear(id)
end

function ArcadeSurvivorShopView:_onCreatePackGoodsItem(obj, data, index)
	obj:onUpdateMO(data, index, self, false)

	self._goodsItemList[index] = obj
end

function ArcadeSurvivorShopView:selectNextCanBuyGoodsIndex()
	if not self._goodsItemList then
		return
	end

	for itemIndex, item in ipairs(self._goodsItemList) do
		if not item:getIsAlreadyBuy() then
			self:onSelectGoods(itemIndex)

			return
		end
	end
end

function ArcadeSurvivorShopView:onSelectGoods(index)
	if not index or self._selectedGoodsIndex == index then
		return
	end

	self._selectedGoodsIndex = index

	if self._goodsItemList then
		for itemIndex, item in ipairs(self._goodsItemList) do
			item:onSelect(itemIndex == self._selectedGoodsIndex)
		end
	end

	self:refreshBtnBuy()
end

function ArcadeSurvivorShopView:refreshBtnBuy()
	local canBuy = false
	local goodsItem = self._goodsItemList and self._goodsItemList[self._selectedGoodsIndex]

	if goodsItem then
		canBuy = goodsItem:getIsCanBuy()
	end

	self._btnbuyanimator:Play(canBuy and "canget" or UIAnimationName.Idle, 0, 0)
	ZProj.UGUIHelper.SetGrayscale(self._btnbuy.gameObject, not canBuy)
end

function ArcadeSurvivorShopView:_onShopStateChange()
	self:refreshGoodsState()
end

function ArcadeSurvivorShopView:refreshGoodsState()
	if self._goodsItemList then
		for _, item in ipairs(self._goodsItemList) do
			item:refreshCanBuy()
		end
	end

	if self._choiceItemList then
		for _, item in ipairs(self._choiceItemList) do
			item:refreshCanBuy()
		end
	end

	self:refreshBtnRefresh()
	self:refreshBtnBuy()
end

function ArcadeSurvivorShopView:refreshBtnRefresh()
	local canRefresh = true
	local haveRefreshCount = ArcadeSurvivorGameModel.instance:getShopRefreshCount()
	local remainCount = math.max(0, haveRefreshCount - self._consumeShopRefreshCount)
	local goodsCount = ArcadeSurvivorConfig.instance:getShopSlot(self._shopId)
	local lockGoodsIdList = ArcadeSurvivorGameModel.instance:getLockGoodsIdList(self._shopGoodsType)
	local lockCount = #lockGoodsIdList

	if remainCount == 0 or goodsCount <= lockCount then
		canRefresh = false
	end

	self._txtrefreshnum.text = remainCount

	self._btnrefreshanimator:Play(canRefresh and "canget" or UIAnimationName.Idle, 0, 0)
	ZProj.UGUIHelper.SetGrayscale(self._btnrefreshanimator.gameObject, not canRefresh)
end

function ArcadeSurvivorShopView:openChoicePanel()
	self._canChoiceCount = ArcadeSurvivorGameModel.instance:getPackSelectableCount()
	self._curPackId = table.remove(self._waitOpenPackIdList, 1)

	local choiceIdList = ArcadeSurvivorGameModel.instance:getChoiceIdList(self._curPackId)

	if not choiceIdList or #choiceIdList == 0 then
		return
	end

	self._choiceItemList = {}

	gohelper.setActive(self._goshop, false)
	gohelper.setActive(self._gochoice, true)
	gohelper.CreateObjList(self, self._onCreateChoiceItem, choiceIdList, self._gochoicecollectionlist, self._gocollectionitem, ArcadeSurvivorShopCollectionItem)
	self:selectNextCanChoiceIndex()
	self._btnselectanimator:Play("canget", 0, 0)
end

function ArcadeSurvivorShopView:_onCreateChoiceItem(obj, data, index)
	obj:onUpdateMO(data, index, self, self._curPackId)

	self._choiceItemList[index] = obj

	ArcadeSurvivorStatHelper.instance:recordCollectionAppear(data)
end

function ArcadeSurvivorShopView:selectNextCanChoiceIndex()
	if not self._choiceItemList then
		return
	end

	for itemIndex, item in ipairs(self._choiceItemList) do
		if not item:getIsAlreadyChoice() then
			self:onSelectChoice(itemIndex)

			return
		end
	end
end

function ArcadeSurvivorShopView:onSelectChoice(index)
	if not index or self._selectedChoiceIndex == index then
		return
	end

	self._selectedChoiceIndex = index

	self:refreshChoiceItemSelected()
end

function ArcadeSurvivorShopView:refreshChoiceItemSelected()
	if not self._choiceItemList then
		return
	end

	for itemIndex, item in ipairs(self._choiceItemList) do
		item:onSelect(itemIndex == self._selectedChoiceIndex)
	end
end

function ArcadeSurvivorShopView:getRerollCollectionId()
	local curCollectionDict = {}

	if self._choiceItemList then
		for _, item in ipairs(self._choiceItemList) do
			local id = item:getId()

			curCollectionDict[id] = true
		end
	end

	local choiceIdList = ArcadeSurvivorGameModel.instance:getChoiceIdList(self._curPackId, 1, curCollectionDict)

	return choiceIdList and choiceIdList[1]
end

function ArcadeSurvivorShopView:clearGoodsItemList(isPlayClose)
	if self._goodsItemList then
		for _, item in ipairs(self._goodsItemList) do
			item:clear(isPlayClose)
		end
	end

	self._goodsItemList = nil
end

function ArcadeSurvivorShopView:clearChoiceItemList()
	if self._choiceItemList then
		for _, item in ipairs(self._choiceItemList) do
			item:clear()
		end

		self._choiceItemList = nil
	end
end

function ArcadeSurvivorShopView:onClose()
	AudioMgr.instance:trigger(AudioEnum4_1.ArcadeSurvivorBgm.reset_voice_volume_ui_8bit_music)

	self._viewBattleField = nil
	self._selectedGoodsIndex = nil
	self._selectedChoiceIndex = nil
	self._consumeShopRefreshCount = 0

	PostProcessingMgr.instance:setViewBlur(self.viewName, nil)
	self:clearChoiceItemList()
	self:clearGoodsItemList()

	if not self._forceClose and not self._isGMOpen then
		ArcadeSurvivorGameController.instance:onShopClosed()
	end

	self._forceClose = nil

	ArcadeSurvivorGameController.instance:resumeGame(ArcadeSurvivorGameEnum.StopSource.Shop)
end

function ArcadeSurvivorShopView:onDestroyView()
	return
end

return ArcadeSurvivorShopView
