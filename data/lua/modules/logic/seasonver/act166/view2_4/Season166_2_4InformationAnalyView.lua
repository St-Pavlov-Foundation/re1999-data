﻿-- chunkname: @modules/logic/seasonver/act166/view2_4/Season166_2_4InformationAnalyView.lua

module("modules.logic.seasonver.act166.view2_4.Season166_2_4InformationAnalyView", package.seeall)

local Season166_2_4InformationAnalyView = class("Season166_2_4InformationAnalyView", BaseView)

function Season166_2_4InformationAnalyView:onInitView()
	self.simageReportPic = gohelper.findChildSingleImage(self.viewGO, "Report/image_Line/image_ReportPic")
	self.goLockedPic = gohelper.findChild(self.viewGO, "Report/image_Line/#go_Locked/image_ReportLockedPic")
	self.lockedCtrl = self.goLockedPic:GetComponent(typeof(ZProj.MaterialPropsCtrl))
	self.simageLockedPic = gohelper.findChildSingleImage(self.viewGO, "Report/image_Line/#go_Locked/image_ReportLockedPic")
	self.btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self.btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self.goDetail = gohelper.findChild(self.viewGO, "Detail")
	self.reportNameTxt = gohelper.findChildTextMesh(self.viewGO, "Detail/#txt_ReportName")
	self.reportNameEnTxt = gohelper.findChildTextMesh(self.viewGO, "Detail/#txt_ReportNameEn")
	self.simageDetailPic = gohelper.findChildSingleImage(self.viewGO, "Detail/#simage_DetailPic")
	self.btnInvestigate = gohelper.findChildButtonWithAudio(self.viewGO, "Detail/#btn_Investigate")
	self.txtCost = gohelper.findChildTextMesh(self.viewGO, "Detail/#btn_Investigate/txt_CostNum")
	self.imgCost = gohelper.findChildImage(self.viewGO, "Detail/#btn_Investigate/#image")
	self.goComplete = gohelper.findChild(self.viewGO, "Detail/#go_Complete")
	self.goScroll = gohelper.findChild(self.viewGO, "Detail/#scorll_Details")
	self.rectScroll = self.goScroll.transform
	self.goContent = gohelper.findChild(self.viewGO, "Detail/#scorll_Details/Viewport/Content")
	self.rectContent = self.goContent.transform
	self.goDesc = gohelper.findChild(self.viewGO, "Detail/#scorll_Details/Viewport/Content/#go_Descr")
	self.goRevealTips = gohelper.findChild(self.viewGO, "Detail/#scorll_Details/Viewport/Content/#go_RevealTips")
	self.goLockInfo = gohelper.findChild(self.viewGO, "LockInfo")
	self.txtLockInfo = gohelper.findChildTextMesh(self.viewGO, "LockInfo/#txt_lockInfo")
	self.detailItems = {}
	self.recycleItemsDict = {}
	self.itemClsDict = {
		Season166InformationAnalyDescItem,
		Season166InformationAnalyTipsItem
	}
	self.itemGODict = {
		self.goDesc,
		self.goRevealTips
	}

	for k, v in pairs(self.itemGODict) do
		gohelper.setActive(v, false)
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season166_2_4InformationAnalyView:addEvents()
	self:addClickCb(self.btnLeft, self.onClickLeft, self)
	self:addClickCb(self.btnRight, self.onClickRight, self)
	self:addClickCb(self.btnInvestigate, self.onClickInvestigate, self)
	self:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, self.onInformationUpdate, self)
	self:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, self.onAnalyInfoSuccess, self)
	self:addEventCb(Season166Controller.instance, Season166Event.ChangeAnalyInfo, self.onChangeAnalyInfo, self)
end

function Season166_2_4InformationAnalyView:removeEvents()
	return
end

function Season166_2_4InformationAnalyView:_editableInitView()
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	self._animEventWrap:AddEventListener("switch", self.checkChangeInfo, self)
end

function Season166_2_4InformationAnalyView:onChangeAnalyInfo(infoId)
	self.infoId = infoId
	self._imgValue = nil

	self:refreshUI()
end

function Season166_2_4InformationAnalyView:onInformationUpdate()
	self:refreshUI()
end

function Season166_2_4InformationAnalyView:onAnalyInfoSuccess(info)
	self:refreshUI()
	self:playTxtFadeInByStage(info.stage)
end

function Season166_2_4InformationAnalyView:onClickLeft()
	self.infoId = self.infoId - 1

	if self.infoId <= 0 then
		local list = Season166Config.instance:getSeasonInfos(self.actId)

		self.infoId = #list
	end

	self.anim:Play(UIAnimationName.Switch, 0, 0)
end

function Season166_2_4InformationAnalyView:onClickRight()
	self.infoId = self.infoId + 1

	local list = Season166Config.instance:getSeasonInfos(self.actId)

	if self.infoId > #list then
		self.infoId = 1
	end

	self.anim:Play(UIAnimationName.Switch, 0, 0)
end

function Season166_2_4InformationAnalyView:checkChangeInfo()
	Season166Controller.instance:dispatchEvent(Season166Event.ChangeAnalyInfo, self.infoId)
end

function Season166_2_4InformationAnalyView:checkCanChangeInfo(infoId)
	return true
end

function Season166_2_4InformationAnalyView:onClickInvestigate()
	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local infoMo = actInfo and actInfo:getInformationMO(self.infoId)
	local list = Season166Config.instance:getSeasonInfoAnalys(self.actId, self.infoId) or {}
	local config = list[infoMo.stage + 1]

	if not config then
		return
	end

	local costCount = config.consume
	local items = {}

	table.insert(items, {
		type = MaterialEnum.MaterialType.Currency,
		id = Season166Config.instance:getSeasonConstNum(self.actId, Season166Enum.InfoCostId),
		quantity = costCount
	})

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItems(items)

	if not enough then
		GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

		return
	end

	Activity166Rpc.instance:sendAct166AnalyInfoRequest(self.actId, self.infoId)
end

function Season166_2_4InformationAnalyView:onUpdateParam()
	return
end

function Season166_2_4InformationAnalyView:onOpen()
	self.actId = self.viewParam.actId
	self.infoId = self.viewParam.infoId

	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wulu_aizila_forward_paper)
	self:refreshUI()
end

function Season166_2_4InformationAnalyView:refreshUI()
	local config = Season166Config.instance:getSeasonInfoConfig(self.actId, self.infoId)

	self.simageReportPic:LoadImage(string.format("singlebg/seasonver/%s_1.png", config.reportRes))
	self.simageLockedPic:LoadImage(string.format("singlebg/seasonver/%s_0.png", config.reportRes))

	self.reportNameTxt.text = config.name
	self.reportNameEnTxt.text = config.nameEn

	self.simageDetailPic:LoadImage(string.format("singlebg/seasonver/%s.png", config.reportPic))

	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local infoMo = actInfo and actInfo:getInformationMO(self.infoId)

	self.unlockState = infoMo and Season166Enum.UnlockState or Season166Enum.LockState

	local isUnlock = self.unlockState == Season166Enum.UnlockState

	if isUnlock then
		self:refreshDetail()
	else
		self:_setImgValue(0)
	end

	self.txtLockInfo.text = config.unlockDes

	gohelper.setActive(self.goDetail, isUnlock)
	gohelper.setActive(self.goLockInfo, not isUnlock)
	self:refreshBtn()
end

function Season166_2_4InformationAnalyView:refreshBtn()
	local list = Season166Config.instance:getSeasonInfos(self.actId)
	local leftId = self.infoId - 1
	local rightId = self.infoId + 1

	if leftId <= 0 then
		leftId = #list
	end

	if rightId > #list then
		rightId = 1
	end

	gohelper.setActive(self.btnLeft, self:checkCanChangeInfo(leftId))
	gohelper.setActive(self.btnRight, self:checkCanChangeInfo(rightId))
end

function Season166_2_4InformationAnalyView:refreshDetail()
	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local infoMo = actInfo and actInfo:getInformationMO(self.infoId)
	local list = Season166Config.instance:getSeasonInfoAnalys(self.actId, self.infoId) or {}
	local infoConfig = Season166Config.instance:getSeasonInfoConfig(self.actId, self.infoId)

	self:recycleItems()

	local analyCount = #list
	local costCfg, showItem

	self:updateItemByData({
		stage = 0,
		content = infoConfig.initContent
	}, infoMo, false)

	for i, v in ipairs(list) do
		local item = self:updateItemByData(v, infoMo, analyCount == i)

		if infoMo.stage + 1 == v.stage then
			costCfg = v
			showItem = item
		end
	end

	self:refreshCost(costCfg)

	local lastStageConfig = list[analyCount]

	self:setComplete(not lastStageConfig or infoMo.stage >= lastStageConfig.stage)
	self:setLockedImgValue()

	if showItem == nil then
		showItem = self.detailItems[#self.detailItems]
	end

	if showItem then
		ZProj.UGUIHelper.RebuildLayout(self.rectContent)

		local contentHeight = math.abs(showItem:getPosY())
		local scrollHeight = recthelper.getHeight(self.rectScroll)
		local posY = math.max(contentHeight - scrollHeight, 0)

		recthelper.setAnchorY(self.rectContent, posY)
	end
end

function Season166_2_4InformationAnalyView:setComplete(value)
	if self.completeValue == value then
		return
	end

	self.completeValue = value

	gohelper.setActive(self.goComplete, value)

	if value then
		AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_wulu_aizila_forward_paper)
	end
end

function Season166_2_4InformationAnalyView:refreshCost(stageConfig)
	if not stageConfig then
		gohelper.setActive(self.btnInvestigate, false)

		return
	end

	gohelper.setActive(self.btnInvestigate, true)

	local costId = Season166Config.instance:getSeasonConstNum(self.actId, Season166Enum.InfoCostId)
	local hasQuantity = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, costId)
	local enough = hasQuantity >= stageConfig.consume

	if enough then
		self.txtCost.text = string.format("-%s", stageConfig.consume)
	else
		self.txtCost.text = string.format("<color=#BF2E11>-%s</color>", stageConfig.consume)
	end

	local currencyCo = CurrencyConfig.instance:getCurrencyCo(costId)
	local currencyname = string.format("%s_1", currencyCo and currencyCo.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imgCost, currencyname, true)
end

function Season166_2_4InformationAnalyView:updateItemByData(config, info, isEnd)
	local item = self:getItem(config, info)

	table.insert(self.detailItems, item)
	item:setData({
		config = config,
		info = info,
		isEnd = isEnd
	})

	return item
end

function Season166_2_4InformationAnalyView:getItem(config, info)
	local itemType

	itemType = info.stage >= config.stage and 1 or 2

	if self.recycleItemsDict[itemType] and #self.recycleItemsDict[itemType] > 0 then
		return table.remove(self.recycleItemsDict[itemType])
	else
		local cls = self.itemClsDict[itemType]
		local itemGO = self.itemGODict[itemType]

		return MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(itemGO), cls, itemType)
	end
end

function Season166_2_4InformationAnalyView:recycleItems()
	for i, v in ipairs(self.detailItems) do
		self:recycleItem(v)
	end

	self.detailItems = {}
end

function Season166_2_4InformationAnalyView:recycleItem(item)
	local itemType = item.itemType

	if not self.recycleItemsDict[itemType] then
		self.recycleItemsDict[itemType] = {}
	end

	table.insert(self.recycleItemsDict[itemType], item)
	item:onRecycle()
end

function Season166_2_4InformationAnalyView:playTxtFadeInByStage(stage)
	for i, v in ipairs(self.detailItems) do
		v:playTxtFadeInByStage(stage)
	end
end

function Season166_2_4InformationAnalyView:setLockedImgValue()
	local actInfo = Season166Model.instance:getActInfo(self.actId)
	local infoMo = actInfo and actInfo:getInformationMO(self.infoId)
	local list = Season166Config.instance:getSeasonInfoAnalys(self.actId, self.infoId) or {}
	local analyCount = #list
	local value = infoMo.stage / analyCount

	if self._imgValue == value then
		return
	end

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._imgValue == nil then
		self:_setImgValue(value)
	else
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._imgValue, value, 1, self._setImgValue, self.playFinishCallBack, self, nil, EaseType.Linear)
	end

	self._imgValue = value
end

function Season166_2_4InformationAnalyView:_setImgValue(value)
	self.lockedCtrl:GetIndexProp(0, 0)

	local vector = self.lockedCtrl.vector_01

	self.lockedCtrl.vector_01 = Vector4.New(value, 0.05, 0, 0)

	self.lockedCtrl:SetIndexProp(0, 0)
end

function Season166_2_4InformationAnalyView:playFinishCallBack()
	return
end

function Season166_2_4InformationAnalyView:onClose()
	return
end

function Season166_2_4InformationAnalyView:onDestroyView()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self.simageLockedPic:UnLoadImage()
	self.simageReportPic:UnLoadImage()
	self.simageDetailPic:UnLoadImage()
end

return Season166_2_4InformationAnalyView
