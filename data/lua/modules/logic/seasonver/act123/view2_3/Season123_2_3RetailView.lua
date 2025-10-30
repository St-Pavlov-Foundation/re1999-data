﻿-- chunkname: @modules/logic/seasonver/act123/view2_3/Season123_2_3RetailView.lua

module("modules.logic.seasonver.act123.view2_3.Season123_2_3RetailView", package.seeall)

local Season123_2_3RetailView = class("Season123_2_3RetailView", BaseView)

function Season123_2_3RetailView:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "bottom/#btn_start/#image_icon")
	self._txtenemylevelnum = gohelper.findChildText(self.viewGO, "bottom/txt_enemylevel/#txt_enemylevelnum")
	self._btncelebrity = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	self._btncards = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_cards/#btn_cards")
	self._gocards = gohelper.findChild(self.viewGO, "rightbtns/#go_cards")
	self._gohasget = gohelper.findChild(self.viewGO, "rightbtns/#go_cards/#go_hasget")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "bottom/#btn_start")
	self._gorewarditem = gohelper.findChild(self.viewGO, "bottom/rewards/rewardlist/#scroll_celebritycard/scrollcontent_seasoncelebritycarditem/#go_rewarditem")
	self._txtlevelname = gohelper.findChildText(self.viewGO, "bottom/#txt_levelname")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "bottom/#btn_start/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_2_3RetailView:addEvents()
	self._btncelebrity:AddClickListener(self._btncelebrityOnClick, self)
	self._btncards:AddClickListener(self._btncardsOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
end

function Season123_2_3RetailView:removeEvents()
	self._btncelebrity:RemoveClickListener()
	self._btncards:RemoveClickListener()
	self._btnstart:RemoveClickListener()
end

function Season123_2_3RetailView:_editableInitView()
	self._txtcardPackageNum = gohelper.findChildText(self.viewGO, "rightbtns/#go_cards/#go_hasget/#txt_num")
	self._rewardItems = {}
end

function Season123_2_3RetailView:onDestroyView()
	Season123RetailController.instance:onCloseView()

	if self._rewardItems then
		for _, item in ipairs(self._rewardItems) do
			item.btnrewardicon:RemoveClickListener()
		end

		self._rewardItems = nil
	end

	Season123Controller.instance:dispatchEvent(Season123Event.SetRetailScene, false)
end

function Season123_2_3RetailView:onOpen()
	local actId = self.viewParam.actId

	self:addEventCb(Season123Controller.instance, Season123Event.GetActInfo, self.refreshUI, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.handleItemChanged, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self.handleItemChanged, self)
	Season123RetailController.instance:onOpenView(actId)

	local actMO = ActivityModel.instance:getActMO(actId)

	if not actMO or not actMO:isOpen() or actMO:isExpired() then
		return
	end

	self:initIconUI()
	self:refreshUI()
	Season123Controller.instance:dispatchEvent(Season123Event.SetRetailScene, true)
	Season123Controller.instance:dispatchEvent(Season123Event.SwitchRetailPrefab, Season123RetailModel.instance.retailId)
end

function Season123_2_3RetailView:onClose()
	return
end

function Season123_2_3RetailView:refreshUI()
	self:refreshInfo()
	self:refreshCardPackageUI()
	self:refreshRecommendLv()
	self:refreshRewards()
	self:refreshTicket()
end

function Season123_2_3RetailView:refreshInfo()
	local retailCO = Season123RetailModel.instance.retailCO

	if retailCO then
		self._txtlevelname.text = tostring(retailCO.desc)
	end
end

function Season123_2_3RetailView:initIconUI()
	self.viewContainer:refreshCurrencyType()

	local actId = Season123RetailModel.instance.activityId
	local ticketId = Season123Config.instance:getEquipItemCoin(actId, Activity123Enum.Const.UttuTicketsCoin)

	if ticketId then
		local currencyCO = CurrencyConfig.instance:getCurrencyCo(ticketId)

		if not currencyCO then
			return
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageicon, tostring(currencyCO.icon) .. "_1")
	else
		logNormal("Season123 ticketId is nil : " .. tostring(actId))
	end
end

function Season123_2_3RetailView:refreshRecommendLv()
	local recommendLevel = Season123RetailModel.instance:getRecommentLevel()

	if recommendLevel then
		self._txtenemylevelnum.text = HeroConfig.instance:getLevelDisplayVariant(recommendLevel)
	else
		self._txtenemylevelnum.text = luaLang("common_none")
	end
end

function Season123_2_3RetailView:refreshRewards()
	local rewardIcons = Season123RetailModel.instance.rewardIcons

	for index, iconUrl in ipairs(rewardIcons) do
		local item = self:getOrCreateRewardItem(index)

		gohelper.setActive(item.go, true)

		if not string.nilorempty(iconUrl) then
			item.simageicon:LoadImage(iconUrl)
		end
	end

	if #self._rewardItems > #rewardIcons then
		for i = #rewardIcons, #self._rewardItems do
			gohelper.setActive(self._rewardItems[i].go, false)
		end
	end
end

function Season123_2_3RetailView:refreshCardPackageUI()
	local cardPackageCount = Season123CardPackageModel.instance.packageCount

	self._gocards:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = cardPackageCount == 0 and 0.5 or 1
	self._txtcardPackageNum.text = cardPackageCount

	gohelper.setActive(self._gohasget, cardPackageCount > 0)
end

function Season123_2_3RetailView:getOrCreateRewardItem(index)
	local item = self._rewardItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._gorewarditem, "item" .. tostring(index))
		item.simageicon = gohelper.findChildSingleImage(item.go, "#simage_rewardicon")
		item.btnrewardicon = gohelper.findChildButtonWithAudio(item.go, "#btn_rewardicon")

		item.btnrewardicon:AddClickListener(self.onClickIcon, self, index)

		item.txtrare = gohelper.findChildText(item.go, "rare/#go_rare1/txt")
		item.txtrare.text = luaLang("dungeon_prob_flag1")
		self._rewardItems[index] = item
	end

	return item
end

function Season123_2_3RetailView:refreshTicket()
	local ticketNum = Season123RetailModel.instance:getUTTUTicketNum()

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, ticketNum <= 0 and "#800015" or "#070706")
end

function Season123_2_3RetailView:handleItemChanged()
	self:refreshCardPackageUI()
	self:refreshTicket()
end

function Season123_2_3RetailView:_btncelebrityOnClick()
	Season123Controller.instance:openSeasonEquipBookView(self.viewParam.actId)
end

function Season123_2_3RetailView:_btncardsOnClick()
	Season123Controller.instance:openSeasonCardPackageView({
		actId = self.viewParam.actId
	})
end

function Season123_2_3RetailView:onClickIcon(index)
	local rewardIconCfgs = Season123RetailModel.instance.rewardIconCfgs
	local itemKV = rewardIconCfgs[index]

	if itemKV then
		MaterialTipController.instance:showMaterialInfo(itemKV[1], itemKV[2])
	end
end

function Season123_2_3RetailView:_btnstartOnClick()
	Season123RetailController.instance:enterRetailFightScene()
end

return Season123_2_3RetailView
