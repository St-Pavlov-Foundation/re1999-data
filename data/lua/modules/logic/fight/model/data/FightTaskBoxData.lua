﻿-- chunkname: @modules/logic/fight/model/data/FightTaskBoxData.lua

module("modules.logic.fight.model.data.FightTaskBoxData", package.seeall)

local FightTaskBoxData = FightDataClass("FightTaskBoxData")

FightTaskBoxData.TaskStatus = {
	Finished = 3,
	Running = 2,
	Init = 1
}

function FightTaskBoxData:onConstructor(proto)
	self.tasks = {}

	for i, v in ipairs(proto.tasks) do
		local task = FightTaskData.New(v)

		self.tasks[v.taskId] = task
	end
end

return FightTaskBoxData
