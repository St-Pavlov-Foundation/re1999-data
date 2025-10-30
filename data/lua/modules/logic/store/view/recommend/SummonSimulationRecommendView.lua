﻿-- chunkname: @modules/logic/store/view/recommend/SummonSimulationRecommendView.lua

module("modules.logic.store.view.recommend.SummonSimulationRecommendView", package.seeall)

local SummonSimulationRecommendView = class("SummonSimulationRecommendView", StoreRecommendBaseSubView)

function SummonSimulationRecommendView:ctor(...)
	SummonSimulationRecommendView.super.ctor(self, ...)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.SummonSimulationPick)
end

function SummonSimulationRecommendView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "view/#simage_bg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "view/#simage_title")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "view/left/#txt_num1")
	self._txtnum2 = gohelper.findChildText(self.viewGO, "view/left/#txt_num2")
	self._txtprice = gohelper.findChildText(self.viewGO, "view/left/#txt_price")
	self._txtdurationTime = gohelper.findChildText(self.viewGO, "view/right/time/#txt_durationTime")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_buy")
	self._btndetail = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonSimulationRecommendView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btndetail:AddClickListener(self._btndetailOnClick, self)
end

function SummonSimulationRecommendView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btndetail:RemoveClickListener()
end

function SummonSimulationRecommendView:_btnbuyOnClick()
	GameFacade.jumpByAdditionParam(self.config.systemJumpCode)
	AudioMgr.instance:trigger(2000001)
end

function SummonSimulationRecommendView:_btndetailOnClick()
	SummonSimulationPickController.instance:openSummonTips(ActivityEnum.Activity.V3a2_SummonSimulationPick)
end

function SummonSimulationRecommendView:_editableInitView()
	self.super._editableInitView(self)

	self._txtprice.text = PayModel.instance:getProductOriginPriceNum(StoreEnum.V3a2_SummonSimulationPickItemId)
end

function SummonSimulationRecommendView:onUpdateParam()
	return
end

function SummonSimulationRecommendView:onOpen()
	self.super.onOpen(self)
	self:refreshUI()
end

function SummonSimulationRecommendView:switchClose(callBack, callBackObj)
	if self._animator then
		self._animator.enabled = false
	end

	if self._animatorPlayer then
		self._animatorPlayer:Play(UIAnimationName.Close, callBack, callBackObj)
	end
end

function SummonSimulationRecommendView:stopAnimator()
	if self._animatorPlayer then
		self._animatorPlayer:Stop()
	end

	if self._animator then
		self._animator.enabled = false
	end
end

function SummonSimulationRecommendView:refreshUI()
	self.config = self.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.SummonSimulationPick)
	self._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(self.config)
end

function SummonSimulationRecommendView:onDestroyView()
	return
end

return SummonSimulationRecommendView
