﻿-- chunkname: @modules/logic/scene/room/fsm/RoomShowTimeCharacterBuilding.lua

module("modules.logic.scene.room.fsm.RoomShowTimeCharacterBuilding", package.seeall)

local RoomShowTimeCharacterBuilding = class("RoomShowTimeCharacterBuilding", JompFSMBaseTransition)

function RoomShowTimeCharacterBuilding:start()
	return
end

function RoomShowTimeCharacterBuilding:check()
	return true
end

function RoomShowTimeCharacterBuilding:onStart(param)
	self._interationId = param.id
	self._actionDict = self._actionDict or {}

	local action = self._actionDict[self._interationId]

	if not action then
		action = RoomActionShowTimeCharacterBuilding.New(self)
		self._actionDict[self._interationId] = action
	end

	action:start(param)
	self:onDone()
end

function RoomShowTimeCharacterBuilding:endState()
	self.fsm:endTransition(self.fromStateName)
end

function RoomShowTimeCharacterBuilding:stop()
	self:endState()
end

function RoomShowTimeCharacterBuilding:clear()
	self:endState()
end

return RoomShowTimeCharacterBuilding
