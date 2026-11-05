-- chunkname: @modules/logic/versionactivity4_1/linkgift/flow/V4a1_LinkGift_ViewOpenFlow.lua

module("modules.logic.versionactivity4_1.linkgift.flow.V4a1_LinkGift_ViewOpenFlow", package.seeall)

local Base = LibFlowSequenceBase
local V4a1_LinkGift_ViewOpenFlow = class("V4a1_LinkGift_ViewOpenFlow", Base)
local kWaitSec = 1.5

function V4a1_LinkGift_ViewOpenFlow:onStart()
	self:addWork(FunctionWork.New(self._viewObj.selectedPage_Video, self._viewObj))
	self:addWork(DelayWork.New(kWaitSec))
	self:addWork(FunctionWork.New(self._viewObj.selectedPage_HeadPortrait, self._viewObj))
	self:addWork(FunctionWork.New(self._viewContainer.savePlayedAnimOpen, self._viewContainer, true))
end

return V4a1_LinkGift_ViewOpenFlow
