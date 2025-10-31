﻿-- chunkname: @modules/logic/rouge2/map/view/attributeup/Rouge2_MapAttributeUpViewContainer.lua

module("modules.logic.rouge2.map.view.attributeup.Rouge2_MapAttributeUpViewContainer", package.seeall)

local Rouge2_MapAttributeUpViewContainer = class("Rouge2_MapAttributeUpViewContainer", BaseViewContainer)

function Rouge2_MapAttributeUpViewContainer:buildViews()
	local views = {}

	table.insert(views, Rouge2_MapAttributeUpView.New())

	return views
end

function Rouge2_MapAttributeUpViewContainer:playOpenTransition()
	self:startViewOpenBlock()

	local addAttrPoint = self.viewParam and self.viewParam.addAttrPoint
	local animName = "open"

	if not addAttrPoint or addAttrPoint <= 0 then
		animName = "openmove"
	end

	local animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	animatorPlayer:Play(animName, self.onPlayOpenTransitionFinish, self)
end

return Rouge2_MapAttributeUpViewContainer
