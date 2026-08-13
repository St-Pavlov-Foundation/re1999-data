-- chunkname: @modules/logic/turnback/model/TurnbackReturnTaskModel.lua

module("modules.logic.turnback.model.TurnbackReturnTaskModel", package.seeall)

local TurnbackReturnTaskModel = class("TurnbackReturnTaskModel", BaseModel)

function TurnbackReturnTaskModel:initJumpUiInfo()
	local turnBackId = TurnbackModel.instance:getCurTurnbackId()

	if not self._taskJumpUIInfos then
		self._taskJumpUIInfos = {}
	end

	if self._taskJumpUIInfos[turnBackId] then
		return self._taskJumpUIInfos[turnBackId]
	end

	self._taskJumpUIInfos[turnBackId] = {}

	for i, co in ipairs(lua_turnback_task.configList) do
		if co.turnbackId == turnBackId and co.listenerType == "ReadTask" and not string.nilorempty(co.jumpUi) then
			self._taskJumpUIInfos[turnBackId][co.id] = string.split(co.jumpUi, "#")
		end
	end

	return self._taskJumpUIInfos[turnBackId]
end

function TurnbackReturnTaskModel:getJumpUiInfo(id)
	local turnBackId = TurnbackModel.instance:getCurTurnbackId()

	if not self._taskJumpUIInfos or not self._taskJumpUIInfos[turnBackId] then
		self:initJumpUiInfo()
	end

	return self._taskJumpUIInfos[turnBackId][id]
end

function TurnbackReturnTaskModel:getCurReadTaskId()
	local turnbackMo = TurnbackModel.instance:getCurTurnbackMo()

	if not turnbackMo then
		return
	end

	local taskIds = turnbackMo:getReturnTaskIds()

	if taskIds then
		for _, id in ipairs(taskIds) do
			local mo = TaskModel.instance:getTaskById(id)

			if mo and mo:isUnfinished() then
				local config = mo.config or TurnbackConfig.instance:getTurnbackTaskCo(id)

				if config and config.listenerType == "ReadTask" then
					return id
				end
			end
		end
	end
end

TurnbackReturnTaskModel.instance = TurnbackReturnTaskModel.New()

return TurnbackReturnTaskModel
