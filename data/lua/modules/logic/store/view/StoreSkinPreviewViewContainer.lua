﻿-- chunkname: @modules/logic/store/view/StoreSkinPreviewViewContainer.lua

module("modules.logic.store.view.StoreSkinPreviewViewContainer", package.seeall)

local StoreSkinPreviewViewContainer = class("StoreSkinPreviewViewContainer", BaseViewContainer)

function StoreSkinPreviewViewContainer:buildViews()
	local views = {}

	table.insert(views, StoreSkinPreviewRightView.New())
	table.insert(views, CharacterSkinLeftView.New())
	table.insert(views, TabViewGroup.New(1, "#go_btntopleft"))
	table.insert(views, StoreSkinPreviewSpineGCView.New())

	return views
end

function StoreSkinPreviewViewContainer:buildTabViews(tabContainerId)
	self.goodsMO = self.viewParam.goodsMO

	local product = self.goodsMO.config.product
	local productInfo = string.splitToNumber(product, "#")
	local skinId = productInfo[2]
	local suitId = HandbookConfig.instance:getSkinSuitIdBySkinId(skinId)
	local isInHandbookSkin = suitId ~= nil

	if isInHandbookSkin then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})
	else
		self.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})
	end

	return {
		self.navigateView
	}
end

function StoreSkinPreviewViewContainer:onPlayOpenTransitionFinish()
	StoreSkinPreviewViewContainer.super.onPlayOpenTransitionFinish(self)

	local animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	animator.enabled = true
end

return StoreSkinPreviewViewContainer
