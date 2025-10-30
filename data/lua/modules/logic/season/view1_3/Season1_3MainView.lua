﻿-- chunkname: @modules/logic/season/view1_3/Season1_3MainView.lua

module("modules.logic.season.view1_3.Season1_3MainView", package.seeall)

local Season1_3MainView = class("Season1_3MainView", BaseView)

function Season1_3MainView:onInitView()
	self._goreadprocess = gohelper.findChild(self.viewGO, "leftbtns/#go_readprocess")
	self._btnreadprocess = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtns/#go_readprocess/#btn_readprocess")
	self._gotask = gohelper.findChild(self.viewGO, "leftbtns/#go_task")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "leftbtns/#go_task/#btn_task")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "leftbtns/#go_task/#go_taskreddot")
	self._gocelebrity = gohelper.findChild(self.viewGO, "rightbtns/#go_celebrity")
	self._btncelebrity = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_celebrity/#btn_celebrity")
	self._goretail = gohelper.findChild(self.viewGO, "rightbtns/#go_retail")
	self._gocurrency = gohelper.findChild(self.viewGO, "rightbtns/#go_retail/#go_currency")
	self._imagecurrencyicon = gohelper.findChildImage(self.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	self._btncurrencyicon = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_retail/#go_currency/#image_currencyicon")
	self._txtcurrencycount = gohelper.findChildText(self.viewGO, "rightbtns/#go_retail/#go_currency/#txt_currencycount")
	self._btnretail = gohelper.findChildButtonWithAudio(self.viewGO, "rightbtns/#go_retail/#btn_retail")
	self._goassemblying = gohelper.findChild(self.viewGO, "rightbtns/#go_retail/#go_assemblying")
	self._gotitle = gohelper.findChild(self.viewGO, "#go_title")
	self._txtunlocktime = gohelper.findChildText(self.viewGO, "#go_title/txt_unlocktime")
	self._goentrance = gohelper.findChild(self.viewGO, "#go_entrance")
	self._gotop = gohelper.findChild(self.viewGO, "#go_entrance/#go_top")
	self._txtindex = gohelper.findChildText(self.viewGO, "#go_entrance/#txt_index")
	self._txtmapname = gohelper.findChildText(self.viewGO, "#go_entrance/#txt_mapname")
	self._btnentrance = gohelper.findChildButtonWithAudio(self.viewGO, "#go_entrance/#btn_entrance", AudioEnum.UI.play_ui_leimi_biguncharted_open)
	self._godiscount = gohelper.findChild(self.viewGO, "#go_discount")
	self._btndiscount = gohelper.findChildButtonWithAudio(self.viewGO, "#go_discount/#btn_discount")
	self._godiscountlock = gohelper.findChild(self.viewGO, "#go_discount_lock")
	self._txtdiscountunlock = gohelper.findChildText(self.viewGO, "#go_discount_lock/#txt_discountunlock")
	self._btndiscountlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_discount_lock/#btn_discountlock")
	self._goMask = gohelper.findChild(self.viewGO, "#go_mask")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_entrance/decorates/#go_arrow")
	self._animationEvent = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._goEnterEffect = gohelper.findChild(self.viewGO, "eff")

	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.SeasonTaskLevel)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season1_3MainView:addEvents()
	self._btnreadprocess:AddClickListener(self._btnreadprocessOnClick, self)
	self._btntask:AddClickListener(self._btntaskOnClick, self)
	self._btncelebrity:AddClickListener(self._btncelebrityOnClick, self)
	self._btnretail:AddClickListener(self._btnretailOnClick, self)
	self._btnentrance:AddClickListener(self._btnentranceOnClick, self)
	self._btndiscount:AddClickListener(self._btndiscountOnClick, self)
	self._btndiscountlock:AddClickListener(self._btndiscountlockOnClick, self)
	self._btncurrencyicon:AddClickListener(self._btncurrencyiconOnClick, self)
	self._animationEvent:AddEventListener("levelup", self.onLevelUp, self)
	self:addEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self:addEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, self._showUTTU, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season1_3MainView:removeEvents()
	self._btnreadprocess:RemoveClickListener()
	self._btntask:RemoveClickListener()
	self._btncelebrity:RemoveClickListener()
	self._btnretail:RemoveClickListener()
	self._btnentrance:RemoveClickListener()
	self._btndiscount:RemoveClickListener()
	self._btndiscountlock:RemoveClickListener()
	self._btncurrencyicon:RemoveClickListener()
	self._animationEvent:RemoveEventListener("levelup")
	self:removeEventCb(Activity104Controller.instance, Activity104Event.RefreshRetail, self._onRefreshRetail, self)
	self:removeEventCb(GuideController.instance, GuideEvent.SeasonShowUTTU, self._showUTTU, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onChangeRetail, self)
end

function Season1_3MainView:hideMask()
	gohelper.setActive(self._goMask, false)
end

function Season1_3MainView:activeMask(active)
	gohelper.setActive(self._goMask, active)
end

function Season1_3MainView:_btndiscountOnClick()
	Activity104Controller.instance:openSeasonSpecialMarketView()
end

function Season1_3MainView:_btndiscountlockOnClick()
	return
end

function Season1_3MainView:_btnretailOnClick()
	Activity104Controller.instance:openSeasonRetailView()
end

function Season1_3MainView:_btnentranceOnClick()
	Activity104Controller.instance:openSeasonMarketView()
end

function Season1_3MainView:_btnreadprocessOnClick()
	Activity104Controller.instance:openSeasonStoreView()
end

function Season1_3MainView:_btntaskOnClick()
	Activity104Controller.instance:openSeasonTaskView()
end

function Season1_3MainView:_btncelebrityOnClick()
	Activity104Controller.instance:openSeasonCardBook()
end

function Season1_3MainView:_btncurrencyiconOnClick()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, id)
end

function Season1_3MainView:_editableInitView()
	self._progressItems = {}

	for i = 1, 7 do
		self._progressItems[i] = self:createProgress(i)
	end
end

function Season1_3MainView:onUpdateParam()
	self:_refreshUI()
	self:checkJump()
end

function Season1_3MainView:onOpen()
	self:activeMask(true)
	TaskDispatcher.cancelTask(self.hideMask, self)
	TaskDispatcher.runDelay(self.hideMask, self, 1.5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_hippie_open)

	self.levelUpStage = self.viewParam and self.viewParam.levelUpStage

	if self.levelUpStage then
		self.viewContainer:getScene():showLevelObjs(self.levelUpStage)
	end

	self:_refreshUI()
	TaskDispatcher.runDelay(self._checkShowEquipSelfChoiceView, self, 0.1)
	self:checkJump()
end

function Season1_3MainView:checkJump()
	local jumpId = self.viewParam and self.viewParam.jumpId
	local jumpParam = self.viewParam and self.viewParam.jumpParam

	if jumpId == Activity104Enum.JumpId.Market then
		Activity104Controller.instance:openSeasonMarketView(jumpParam)
	elseif jumpId == Activity104Enum.JumpId.Retail then
		Activity104Controller.instance:openSeasonRetailView(jumpParam)
	elseif jumpId == Activity104Enum.JumpId.Discount then
		Activity104Controller.instance:openSeasonSpecialMarketView(jumpParam)
	end
end

function Season1_3MainView:_checkShowEquipSelfChoiceView()
	Activity104Controller.instance:checkShowEquipSelfChoiceView()
end

function Season1_3MainView:onLevelUp()
	if not self.levelUpStage then
		return
	end

	self:activeProgressLevup(self.levelUpStage, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_symbol_upgrade)

	self._passStage = self.levelUpStage

	TaskDispatcher.runDelay(self._showPassTips, self, 0.6)

	self.levelUpStage = nil
end

function Season1_3MainView:_showPassTips()
	if self._passStage == 7 then
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips2)
	else
		GameFacade.showToast(ToastEnum.SeasonMarketPassTips1)
	end
end

function Season1_3MainView:_refreshUI()
	self:_refreshMain()
	self:_refreshRetail()
	TaskDispatcher.cancelTask(self._refreshMain, self)
	TaskDispatcher.runRepeat(self._refreshMain, self, 60)
end

local indexNormalPos = Vector2(-92.8, -42.3)
local indexMaxLayerPos = Vector2(-76.6, -42.3)
local arrowNormalPos = Vector2(53.3, 15.7)
local arrowMaxLayerPos = Vector2(72, 16.1)

function Season1_3MainView:_refreshMain()
	local actId = Activity104Model.instance:getCurSeasonId()
	local spOpen = Activity104Model.instance:isSpecialOpen()
	local isEnterSpecial = Activity104Model.instance:isEnterSpecial()
	local layer = Activity104Model.instance:getAct104CurLayer()
	local maxLayer = Activity104Model.instance:getMaxLayer()
	local openLayerCo = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SpecialOpenLayer)
	local openLayer = openLayerCo and openLayerCo.value1 or 0
	local layerReached = openLayer < layer

	gohelper.setActive(self._godiscount, spOpen)
	gohelper.setActive(self._godiscountlock, isEnterSpecial or layerReached)

	if not spOpen then
		if layerReached then
			local dayCo = SeasonConfig.instance:getSeasonConstCo(actId, Activity104Enum.ConstEnum.SpecialOpenDayCount)
			local dayCount = dayCo.value1 - 1
			local limitSec = ActivityModel.instance:getActStartTime(actId) / 1000 + dayCount * 86400 - ServerTime.now()
			local timeStr = string.format("%s%s", TimeUtil.secondToRoughTime2(limitSec))

			self._txtdiscountunlock.text = string.format(luaLang("seasonmainview_timeopencondition"), timeStr)
		else
			self._txtdiscountunlock.text = string.format(luaLang("seasonmainview_layeropencondition"), openLayer)
		end
	else
		gohelper.setActive(self._godiscountlock, false)
	end

	self._txtindex.text = string.format("%02d", layer)

	local targetIndexPos = maxLayer == layer and indexMaxLayerPos or indexNormalPos
	local targetArrowPos = maxLayer == layer and arrowMaxLayerPos or arrowNormalPos

	recthelper.setAnchor(self._txtindex.transform, targetIndexPos.x, targetIndexPos.y)
	recthelper.setAnchor(self._goarrow.transform, targetArrowPos.x, targetArrowPos.y)
	gohelper.setActive(self._gotop, maxLayer == layer and Activity104Model.instance:isLayerPassed(actId, layer))

	local episodeCo = SeasonConfig.instance:getSeasonEpisodeCo(actId, layer)

	self._txtmapname.text = episodeCo.stageName

	local stage = Activity104Model.instance:getAct104CurStage()

	self:activeProgress(7, stage == 7)

	for i, v in ipairs(self._progressItems) do
		self:updateProgress(i, stage)
	end

	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	local day = Mathf.Floor(offsetSecond / TimeUtil.OneDaySecond)
	local hourSecond = offsetSecond % TimeUtil.OneDaySecond
	local hour = Mathf.Floor(hourSecond / TimeUtil.OneHourSecond)
	local timeStr = GameUtil.getSubPlaceholderLuaLang(luaLang("time_day_hour2"), {
		day,
		hour
	})

	self._txtunlocktime.text = formatLuaLang("remain", timeStr)
end

function Season1_3MainView:_refreshRetail()
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)
	local currencyCo = CurrencyConfig.instance:getCurrencyCo(id)
	local currencyname = currencyCo and currencyCo.icon

	if currencyname then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrencyicon, currencyname .. "_1", true)
	end

	local isOpen = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SeasonRetail)
	local isInUTTUGuide = GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonUTTU)
	local isInGuide = isInUTTUGuide or GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SeasonDiscount)

	gohelper.setActive(self._goretail, isOpen and not isInUTTUGuide)

	self._retailProcessing = #Activity104Model.instance:getAct104Retails() > 0

	gohelper.setActive(self._goassemblying, self._retailProcessing)
	gohelper.setActive(self._gocurrency, not self._retailProcessing)

	if not self._retailProcessing then
		local needTicket = currencyCo and currencyCo.recoverLimit
		local readableMo = CurrencyModel.instance:getCurrency(id)
		local hasTicket = readableMo and readableMo.quantity or 0

		self._hasEnoughTicket = hasTicket >= 1

		local hasTxt = hasTicket > 0 and hasTicket or "<color=#CF4543>" .. hasTicket .. "</color>"

		self._txtcurrencycount.text = string.format("%s/%s", hasTxt, needTicket)
	end

	gohelper.setActive(self._goEnterEffect, not isInGuide)

	if isInGuide then
		local animator = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))

		if animator then
			animator:Play(UIAnimationName.Switch, 0, 1.8)
		end
	end
end

function Season1_3MainView:_showUTTU()
	self:_refreshRetail()

	local animator = gohelper.onceAddComponent(self._goretail, typeof(UnityEngine.Animator))

	if animator then
		animator:Play(UIAnimationName.Switch, 0, 0)
	end
end

function Season1_3MainView:_onRefreshRetail()
	self:_refreshRetail()
end

function Season1_3MainView:_onChangeRetail(changeIds)
	local actId = Activity104Model.instance:getCurSeasonId()
	local id = SeasonConfig.instance:getRetailTicket(actId)

	if not id or not changeIds[id] then
		return
	end

	self:_refreshRetail()
end

function Season1_3MainView:createProgress(index)
	local item = self:getUserDataTb_()

	item.go = gohelper.findChild(self.viewGO, string.format("#go_entrance/progress/#go_progress%s", index))
	item.dark = gohelper.findChild(item.go, "dark")
	item.light = gohelper.findChild(item.go, "light")
	item.lightImg = item.light:GetComponent(gohelper.Type_Image)
	item.leveup = gohelper.findChild(item.go, "leveup")

	return item
end

function Season1_3MainView:activeProgress(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.go, active)
end

function Season1_3MainView:activeProgressLevup(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.leveup, active)
end

function Season1_3MainView:activeProgressLight(index, active)
	local item = self._progressItems[index]

	if not item then
		return
	end

	gohelper.setActive(item.light, active)
end

function Season1_3MainView:updateProgress(index, stage)
	local item = self._progressItems[index]

	if not item then
		return
	end

	local color = index == 7 and "#B83838" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(item.lightImg, color)
	gohelper.setActive(item.light, index <= stage and self.levelUpStage ~= index)
	gohelper.setActive(item.dark, stage < index)
end

function Season1_3MainView:onClose()
	return
end

function Season1_3MainView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshMain, self)
	TaskDispatcher.cancelTask(self.hideMask, self)
	TaskDispatcher.cancelTask(self._showPassTips, self)
	TaskDispatcher.cancelTask(self._checkShowEquipSelfChoiceView, self)
end

return Season1_3MainView
