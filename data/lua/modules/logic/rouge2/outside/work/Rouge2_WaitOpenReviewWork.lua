﻿-- chunkname: @modules/logic/rouge2/outside/work/Rouge2_WaitOpenReviewWork.lua

module("modules.logic.rouge2.outside.work.Rouge2_WaitOpenReviewWork", package.seeall)

local Rouge2_WaitOpenReviewWork = class("Rouge2_WaitOpenReviewWork", BaseWork)

function Rouge2_WaitOpenReviewWork:onStart()
	local resultInfo = Rouge2_Model.instance:getRougeResult()
	local finalScore = resultInfo and resultInfo.finalScore or 0

	if finalScore <= 0 then
		return self:onDone(true)
	end

	self.flow = FlowSequence.New()

	self.flow:addWork(OpenViewAndWaitCloseWork.New(ViewName.Rouge2_ResultFinalView))
	self.flow:registerDoneListener(self._onFlowDone, self)
	self.flow:start()
end

function Rouge2_WaitOpenReviewWork:_onFlowDone()
	self:onDone(true)
end

function Rouge2_WaitOpenReviewWork:clearWork()
	if self.flow then
		self.flow:destroy()

		self.flow = nil
	end
end

return Rouge2_WaitOpenReviewWork
