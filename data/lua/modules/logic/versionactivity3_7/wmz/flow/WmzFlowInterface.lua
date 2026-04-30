-- chunkname: @modules/logic/versionactivity3_7/wmz/flow/WmzFlowInterface.lua

module("modules.logic.versionactivity3_7.wmz.flow.WmzFlowInterface", package.seeall)

local WmzFlowInterface = class("WmzFlowInterface")

function WmzFlowInterface:checkIsCompleted(...)
	return self.dragContext:checkIsCompleted(...)
end

function WmzFlowInterface:setCompleted(...)
	return self.dragContext:setCompleted(...)
end

function WmzFlowInterface:getGroupListByGroupId(...)
	return self.viewContainer:getGroupListByGroupId(...)
end

function WmzFlowInterface:setRound(...)
	self.viewContainer:setRound(...)
end

function WmzFlowInterface:completeGame(...)
	self.viewContainer:completeGame(...)
end

return WmzFlowInterface
