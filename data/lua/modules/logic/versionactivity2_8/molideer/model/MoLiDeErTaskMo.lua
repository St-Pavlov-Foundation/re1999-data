﻿-- chunkname: @modules/logic/versionactivity2_8/molideer/model/MoLiDeErTaskMo.lua

module("modules.logic.versionactivity2_8.molideer.model.MoLiDeErTaskMo", package.seeall)

local MoLiDeErTaskMo = pureTable("MoLiDeErTaskMo")

function MoLiDeErTaskMo:init(taskCfg, taskMO)
	self.id = taskCfg.id
	self.activityId = taskCfg.activityId
	self.config = taskCfg
	self.taskMO = taskMO
	self.preFinish = false
end

function MoLiDeErTaskMo:updateMO(taskMO)
	self.taskMO = taskMO
end

function MoLiDeErTaskMo:isLock()
	return self.taskMO == nil
end

function MoLiDeErTaskMo:isFinished()
	if self.preFinish then
		return true
	end

	if self.taskMO then
		return self.taskMO.finishCount > 0
	end

	return false
end

function MoLiDeErTaskMo:getMaxProgress()
	return self.config and self.config.maxProgress or 0
end

function MoLiDeErTaskMo:getFinishProgress()
	return self.taskMO and self.taskMO.progress or 0
end

function MoLiDeErTaskMo:alreadyGotReward()
	local maxProgress = self:getMaxProgress()

	if maxProgress > 0 and self.taskMO then
		return maxProgress <= self.taskMO.progress and self.taskMO.finishCount == 0
	end

	return false
end

return MoLiDeErTaskMo
