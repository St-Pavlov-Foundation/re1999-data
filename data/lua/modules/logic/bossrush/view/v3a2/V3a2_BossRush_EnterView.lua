﻿-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_EnterView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_EnterView", package.seeall)

local V3a2_BossRush_EnterView = class("V3a2_BossRush_EnterView", VersionActivityEnterBaseSubView)

function V3a2_BossRush_EnterView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageBOSS1 = gohelper.findChildSingleImage(self.viewGO, "BOSS/#simage_BOSS1")
	self._simageBOSS2 = gohelper.findChildSingleImage(self.viewGO, "BOSS/#simage_BOSS2")
	self._simageBOSS3 = gohelper.findChildSingleImage(self.viewGO, "BOSS/#simage_BOSS3")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Left/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Left/LimitTime/#txt_LimitTime")
	self._btnStore = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Store/#btn_Store")
	self._simageProp = gohelper.findChildSingleImage(self.viewGO, "Right/Store/#btn_Store/#simage_Prop")
	self._txtNum = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/#txt_Num")
	self._gorank = gohelper.findChild(self.viewGO, "Right/#go_rank")
	self._btnNormal = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Normal/click")
	self._btnUnOpen = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_UnOpen/click")
	self._goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Normal/#go_reddot")
	self._txtTips = gohelper.findChildText(self.viewGO, "Right/#btn_UnOpen/image_TIps/#txt_Tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_EnterView:addEvents()
	self._btnStore:AddClickListener(self._btnStoreOnClick, self)
	self._btnNormal:AddClickListener(self._btnNormalOnClick, self)
	self._btnUnOpen:AddClickListener(self._btnUnOpenOnClick, self)
	self:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self:addEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_EnterView:removeEvents()
	self._btnStore:RemoveClickListener()
	self._btnNormal:RemoveClickListener()
	self._btnUnOpen:RemoveClickListener()
	self:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, self._refreshStoreTag, self)
	self:removeEventCb(RedDotController.instance, RedDotEvent.UpdateActTag, self._refreshStoreTag, self)
	self:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.OnEnterStoreView, self._refreshStoreTag, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_EnterView:_btnUnOpenOnClick()
	self:_enterActivity()
end

function V3a2_BossRush_EnterView:_btnStoreOnClick()
	BossRushController.instance:openBossRushStoreView(self.actId)
end

function V3a2_BossRush_EnterView:_btnNormalOnClick()
	self:_enterActivity()
end

function V3a2_BossRush_EnterView:_enterActivity()
	if self._isInfo then
		BossRushController.instance:openV3a2MainView()
	end
end

function V3a2_BossRush_EnterView:_editableInitView()
	self._goStoreTip = gohelper.findChild(self.viewGO, "Right/Store/image_Tips")
	self._txtStore = gohelper.findChildText(self.viewGO, "Right/Store/#btn_Store/txt_Store")
	self._txtActDesc = gohelper.findChildText(self.viewGO, "Left/txtDescr")

	local nameCn, nameEn = V1a6_BossRush_StoreModel.instance:getStoreGroupName(StoreEnum.BossRushStore.ManeTrust)

	self._txtStore.text = nameCn
	self._itemObjects = {}

	local actInfoMo = BossRushModel.instance:getActivityMo()

	if actInfoMo then
		self._txtActDesc.text = actInfoMo.config.actDesc

		local rewards = GameUtil.splitString2(actInfoMo.config.activityBonus, true)

		if rewards then
			for i, reward in ipairs(rewards) do
				local item = self._itemObjects[i]

				if not item then
					item = IconMgr.instance:getCommonPropItemIcon(self._gorewardcontent)

					table.insert(self._itemObjects, item)
				end

				item:setMOValue(reward[1], reward[2], 1)
				item:isShowCount(false)
			end
		end

		if actInfoMo.config.openId and actInfoMo.config.openId > 0 then
			local unlockTxt = OpenHelper.getActivityUnlockTxt(actInfoMo.config.openId)

			self._txtTips.text = unlockTxt
		end
	end

	self:_initRank()
end

function V3a2_BossRush_EnterView:_initRank()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.loader = MultiAbLoader.New()

	self.loader:addPath(BossRushEnum.ResPath.v3a2_bossrush_rankbtn)
	self.loader:startLoad(self.loadResFinish, self)
end

function V3a2_BossRush_EnterView:loadResFinish()
	local assetItem = self.loader:getAssetItem(BossRushEnum.ResPath.v3a2_bossrush_rankbtn)
	local res = assetItem:GetResource(BossRushEnum.ResPath.v3a2_bossrush_rankbtn)
	local go = gohelper.clone(res, self._gorank)

	self._rankBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, V3a2_BossRush_RankBtn)

	if self._isInfo then
		self._rankBtn:refreshUI()
	end
end

function V3a2_BossRush_EnterView:onOpen()
	V3a2_BossRush_EnterView.super.onOpen(self)

	self.actId = BossRushConfig.instance:getActivityId()

	local actInfoMo = ActivityModel.instance:getActivityInfo()[self.actId]
	local isOpen = actInfoMo and ActivityHelper.getActivityStatus(self.actId) == ActivityEnum.ActivityStatus.Normal
	local goGo = gohelper.findChild(self.viewGO, "Right/#btn_Normal")
	local goUnOpen = gohelper.findChild(self.viewGO, "Right/#btn_UnOpen")
	local goreddot = gohelper.findChild(self.viewGO, "Right/#btn_Normal/#go_reddot")

	gohelper.setActive(goGo, isOpen)
	gohelper.setActive(goUnOpen, not isOpen)

	local defineId = RedDotEnum.DotNode.BossRushEnter

	RedDotController.instance:addRedDot(goreddot, defineId)

	self._isInfo = false

	BossRushRpc.instance:sendGet128InfosRequest(function()
		if self._rankBtn then
			self._rankBtn:refreshUI()
		end

		self._isInfo = true
	end)

	if not actInfoMo then
		self._txtLimitTime.text = ""
	end

	self:_refreshCurrency()
	self:_refreshTime()
	V1a6_BossRush_StoreModel.instance:readAllStoreGroupNewData()
	V1a6_BossRush_StoreModel.instance:checkStoreNewGoods()
	self:_refreshStoreTag()
end

function V3a2_BossRush_EnterView:onClose()
	V3a2_BossRush_EnterView.super.onClose(self)
end

function V3a2_BossRush_EnterView:onDestroyView()
	if self.rewardItems then
		for k, v in pairs(self.rewardItems) do
			v:onDestroy()
		end

		self.rewardItems = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

function V3a2_BossRush_EnterView:_refreshStoreTag()
	local isNew = V1a6_BossRush_StoreModel.instance:isHasNewGoodsInStore()

	gohelper.setActive(self._goStoreTip, isNew)
end

function V3a2_BossRush_EnterView:playRankBtnAnim()
	if self._rankBtn then
		self._rankBtn:playAnim()
	end
end

function V3a2_BossRush_EnterView:_refreshTime()
	local actInfoMo = BossRushModel.instance:getActivityMo()

	if actInfoMo then
		local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

		gohelper.setActive(self._txtLimitTime.gameObject, offsetSecond > 0)

		if offsetSecond > 0 then
			local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

			self._txtLimitTime.text = dateStr
		end
	end
end

function V3a2_BossRush_EnterView:_refreshCurrency()
	local count = V1a6_BossRush_StoreModel.instance:getCurrencyCount(self.actId)

	if count then
		self._txtNum.text = count
	end
end

function V3a2_BossRush_EnterView:everySecondCall()
	self:_refreshTime()
end

return V3a2_BossRush_EnterView
