﻿-- chunkname: @modules/logic/guide/controller/action/impl/GuideActionSetFlag.lua

module("modules.logic.guide.controller.action.impl.GuideActionSetFlag", package.seeall)

local GuideActionSetFlag = class("GuideActionSetFlag", BaseGuideAction)

function GuideActionSetFlag:onStart(context)
	GuideActionSetFlag.super.onStart(self, context)

	local temp = string.split(self.actionParam, "#")
	local flagId = tonumber(temp[1])
	local enable = temp[2] == "1"
	local exParam = temp[3] or true

	if enable then
		GuideModel.instance:setFlag(flagId, exParam, self.guideId)
	else
		GuideModel.instance:setFlag(flagId, nil, self.guideId)
	end

	self:onDone(true)
end

return GuideActionSetFlag
