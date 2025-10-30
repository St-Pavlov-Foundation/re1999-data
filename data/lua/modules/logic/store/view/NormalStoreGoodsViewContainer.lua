﻿-- chunkname: @modules/logic/store/view/NormalStoreGoodsViewContainer.lua

module("modules.logic.store.view.NormalStoreGoodsViewContainer", package.seeall)

local NormalStoreGoodsViewContainer = class("NormalStoreGoodsViewContainer", BaseViewContainer)

function NormalStoreGoodsViewContainer:buildViews()
	local views = {}

	table.insert(views, TabViewGroup.New(1, "#go_topright"))
	table.insert(views, NormalStoreGoodsView.New())

	return views
end

function NormalStoreGoodsViewContainer:buildTabViews(tabContainerId)
	self._currencyView = CurrencyView.New({})

	return {
		self._currencyView
	}
end

function NormalStoreGoodsViewContainer:setCurrencyType(currencyId)
	local currencyTypeParam = {
		currencyId
	}

	if CurrencyEnum.CurrencyType.FreeDiamondCoupon == currencyId then
		currencyTypeParam = {
			CurrencyEnum.CurrencyType.Diamond,
			CurrencyEnum.CurrencyType.FreeDiamondCoupon
		}
	end

	if self._currencyView then
		self._currencyView:setCurrencyType(currencyTypeParam)
	end
end

function NormalStoreGoodsViewContainer:setCurrencyTypes(currencyIds)
	if self._currencyView then
		self._currencyView:setCurrencyType(currencyIds)
	end
end

function NormalStoreGoodsViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return NormalStoreGoodsViewContainer
