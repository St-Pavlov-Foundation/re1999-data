-- chunkname: @modules/logic/sodache/controller/work/step/SodacheStepDeleteTaskWork.lua

module("modules.logic.sodache.controller.work.step.SodacheStepDeleteTaskWork", package.seeall)

local SodacheStepDeleteTaskWork = class("SodacheStepDeleteTaskWork", SodacheStepBaseWork)

function SodacheStepDeleteTaskWork:onStart(context)
	self:onDone(true)
end

function SodacheStepDeleteTaskWork:isInsideStep()
	return false
end

return SodacheStepDeleteTaskWork
