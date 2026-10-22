-- chunkname: @modules/logic/tips/view/MaterialHeroRecoveryTipView.lua

module("modules.logic.tips.view.MaterialHeroRecoveryTipView", package.seeall)

local MaterialHeroRecoveryTipView = class("MaterialHeroRecoveryTipView", BaseView)

function MaterialHeroRecoveryTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/Right/layout2/#scroll_reward")
	self._goexskill = gohelper.findChild(self.viewGO, "root/heroitem/role/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "root/heroitem/role/#go_exskill/#image_exskill")
	self._goclick = gohelper.findChild(self.viewGO, "root/heroitem/select/#go_click")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_confirm")
	self._goselecticon = gohelper.findChild(self.viewGO, "root/TipsBG/txt_Tips/#go_selecticon")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "root/TipsBG/txt_Tips/#btn_tips")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/TipsBG/#btn_click")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MaterialHeroRecoveryTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function MaterialHeroRecoveryTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._btntips:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

local Recovery_RewardItem = {
	itemId = 401002,
	itemType = 1
}

function MaterialHeroRecoveryTipView:_btncloseOnClick()
	self:closeThis()
end

function MaterialHeroRecoveryTipView:_btnconfirmOnClick()
	if not self:_isSelectOp() then
		GameFacade.showToast(ToastEnum.MaterialTipHeroRecoveryReadDesc)

		return
	end

	if self._nextConfirmClickTime and self._nextConfirmClickTime > Time.time then
		self._nextConfirmClickTime = Time.time + 1

		GameFacade.showToast(ToastEnum.TurnbackNewProgressViewRefresh)

		return
	end

	if self._isDeleteHero then
		GameFacade.showMessageBox(MessageBoxIdDefine.DeleteHeroRecoveryTip, MsgBoxEnum.BoxType.Yes_No, self._onConfirmClickYes, nil, nil, self, nil, nil)
	else
		self:_onConfirmClickYes()
	end
end

function MaterialHeroRecoveryTipView:_onConfirmClickYes()
	if self._isDeleteHero then
		MaterialHeroRecoveryController.instance:heroRecoverLogic(self._heroId)
	end

	if not self._isSended_ then
		self._isSended_ = true

		self:addEventCb(BackpackController.instance, BackpackEvent.onUseItemFinished, self.closeThis, self)
	end

	ItemRpc.instance:simpleSendUseItemRequest(self._itemId, 1)
end

function MaterialHeroRecoveryTipView:_btntipsOnClick()
	MaterialHeroRecoveryController.instance:openHeroRecoveryWindowView(self._onReadingFinishCb, self)
end

function MaterialHeroRecoveryTipView:_btnclickOnClick()
	if self:_isSelectOp() then
		self:_setSelectOp(false)
	else
		MaterialHeroRecoveryController.instance:openHeroRecoveryWindowView(self._onReadingFinishCb, self)
	end
end

function MaterialHeroRecoveryTipView:_onReadingFinishCb()
	self:_setSelectOp(true)
end

function MaterialHeroRecoveryTipView:_editableInitView()
	self._goheroitem = gohelper.findChild(self.viewGO, "root/heroitem")
	self._goleftlayout = gohelper.findChild(self.viewGO, "root/Left/layout")
	self._gorightlayout = gohelper.findChild(self.viewGO, "root/Right/layout")
	self._gorightlayout2 = gohelper.findChild(self.viewGO, "root/Right/layout2")
	self._goselected = gohelper.findChild(self._goselecticon, "selected")
	self._gobtnconfirm = gohelper.findChild(self.viewGO, "root/#btn_confirm")
	self._leftLayerTb = self:getUserDataTb_()
	self._leftLayerTb.golayout = self._goleftlayout
	self._rightLayerTb = self:getUserDataTb_()
	self._rightLayerTb.golayout = self._gorightlayout

	self:_setSelectOp(false)
end

function MaterialHeroRecoveryTipView:onUpdateParam()
	return
end

function MaterialHeroRecoveryTipView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)

	self._heroMO = nil
	self._itemType = self.viewParam.itemType
	self._itemId = self.viewParam.itemId

	local config = ItemModel.instance:getItemConfig(self._itemType, self._itemId)

	self._heroId = tonumber(config.effect)
	self._heroMO = HeroModel.instance:getByHeroId(self._heroId)

	if not self._heroMO then
		return
	end

	self:_refreshUI()
end

function MaterialHeroRecoveryTipView:onClose()
	self:removeEventCb(BackpackController.instance, BackpackEvent.onUseItemFinished, self.closeThis, self)
end

function MaterialHeroRecoveryTipView:onDestroyView()
	self:_disposeLayoutTb(self._leftLayerTb)
	self:_disposeLayoutTb(self._rightLayerTb)
end

function MaterialHeroRecoveryTipView:_isSelectOp()
	return self._isSelecticonOp
end

function MaterialHeroRecoveryTipView:_setSelectOp(isSelectOp)
	self._isSelecticonOp = isSelectOp == true

	gohelper.setActive(self._goselected, self._isSelecticonOp)
	ZProj.UGUIHelper.SetGrayscale(self._gobtnconfirm, self._isSelecticonOp ~= true)
end

function MaterialHeroRecoveryTipView:_refreshUI()
	local xsItemType, xsItemId, xsItemNum = self:getHeroXskillItem(self._heroId)
	local recoverItemDataList = {}
	local rewardItemDataList = {}

	self._isDeleteHero = false

	local leftHeroMO, rightHeroMO

	table.insert(rewardItemDataList, HeroRecoveryHelper.creteItemData(Recovery_RewardItem.itemType, Recovery_RewardItem.itemId, 1))

	local duplicateCountVal = CommonConfig.instance:getConstNum(ConstEnum.HeroDuplicateGetCount)

	if self._heroMO.duplicateCount >= duplicateCountVal - 1 then
		-- block empty
	elseif xsItemType and xsItemId and xsItemNum and xsItemNum > 0 then
		table.insert(recoverItemDataList, HeroRecoveryHelper.creteItemData(xsItemType, xsItemId, 1))
	elseif self._heroMO.exSkillLevel > 0 then
		local mergeInfo = {
			exSkillLevel = self._heroMO.exSkillLevel - 1
		}

		rightHeroMO = HeroRecoveryHelper.mergeHeroMO(self._heroMO, mergeInfo)
		leftHeroMO = self._heroMO
	else
		self._isDeleteHero = true
		leftHeroMO = self._heroMO

		tabletool.addValues(rewardItemDataList, HeroRecoveryHelper.giveback‌ItemListByHeroId(self._heroId))
	end

	tabletool.addValues(recoverItemDataList, HeroRecoveryHelper.recoverItemListByHeroId(self._heroId, self._heroMO.duplicateCount))
	self:_refreshLayoutTb(self._leftLayerTb, leftHeroMO, recoverItemDataList)
	table.sort(rewardItemDataList, HeroRecoveryHelper.sortItemDataFunc)

	if self._isDeleteHero then
		MaterialHeroRecoveryTipListModel.instance:setData(rewardItemDataList)
	else
		self:_refreshLayoutTb(self._rightLayerTb, rightHeroMO, rewardItemDataList)
		MaterialHeroRecoveryTipListModel.instance:clear()
	end

	gohelper.setActive(self._gorightlayout, self._isDeleteHero == false)
	gohelper.setActive(self._gorightlayout2, self._isDeleteHero ~= false)
end

function MaterialHeroRecoveryTipView:_refreshLayoutTb(layoutTb, heroMO, itemDataList)
	if not layoutTb or layoutTb._isDispose == true then
		logError("MaterialHeroRecoveryTipView:_refreshLayoutTb => layoutTb is nil")

		return
	end

	if layoutTb.heroComp then
		gohelper.setActive(layoutTb.heroComp.go, heroMO ~= nil)
	end

	if heroMO then
		if not layoutTb.heroComp then
			layoutTb.heroComp = IconMgr.instance:getCommonHeroLeveIcon(layoutTb.golayout)

			gohelper.setAsFirstSibling(layoutTb.heroComp.go)
		end

		layoutTb.heroComp:onUpdateMO(heroMO)
	end

	if not layoutTb.itemCompList then
		layoutTb.itemCompList = {}
	end

	local itemCompList = layoutTb.itemCompList
	local itemCount = 0

	if itemDataList then
		itemCount = #itemDataList

		for idx, itemData in ipairs(itemDataList) do
			local itemComp = itemCompList[idx]

			if not itemComp then
				local go = self:getResInst(IconMgrConfig.UrlItemIcon, layoutTb.golayout)

				itemComp = MonoHelper.addNoUpdateLuaComOnceToGo(go, CommonItemIcon)

				table.insert(itemCompList, itemComp)
				gohelper.setActive(go, true)
			end

			itemComp:onUpdateMO(itemData)
		end
	end

	for idx, itemComp in ipairs(itemCompList) do
		gohelper.setActive(itemComp.go, idx <= itemCount)
	end
end

function MaterialHeroRecoveryTipView:_disposeLayoutTb(layoutTb)
	if layoutTb and layoutTb._isDispose ~= true then
		layoutTb._isDispose = true

		if layoutTb.heroComp then
			layoutTb.heroComp:onDestroy()
		end

		if layoutTb.itemCompList then
			for _, itemComp in ipairs(layoutTb.itemCompList) do
				itemComp:onDestroy()
			end
		end
	end
end

function MaterialHeroRecoveryTipView:getHeroXskillItem(heroId)
	local exCo = SkillConfig.instance:getheroexskillco(heroId)

	if exCo and #exCo > 0 then
		for i = 1, #exCo do
			local co = exCo[i]

			if co and not string.nilorempty(co.consume) then
				local itemco = string.splitToNumber(co.consume, "#")
				local itemType = itemco[1]
				local itemId = itemco[2]

				return itemType, itemId, ItemModel.instance:getItemQuantity(itemType, itemId)
			end
		end
	end
end

return MaterialHeroRecoveryTipView
