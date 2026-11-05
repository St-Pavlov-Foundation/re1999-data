-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryFsmComp_IdleState.lua

local math_random = math.random

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryFsmComp_IdleState", package.seeall)

local V4a1_LibraryFsmComp_IdleState = class("V4a1_LibraryFsmComp_IdleState", V4a1_LibraryFsmComp_StateBase)

function V4a1_LibraryFsmComp_IdleState:type()
	return V4a1_LibraryEnum.State.Idle
end

function V4a1_LibraryFsmComp_IdleState:ctor(...)
	V4a1_LibraryFsmComp_IdleState.super.ctor(self, ...)
end

function V4a1_LibraryFsmComp_IdleState:onEnter()
	self:spineComp():playState(V4a1_LibraryEnum.SpineAnim.Idle)

	self._nextWalkTime = Time.realtimeSinceStartup + self:_getWaitTime()
end

function V4a1_LibraryFsmComp_IdleState:_getWaitTime()
	local range = self:unitObj():getCharIdleDurationRangeByCO()

	return math_random(range.min, range.max)
end

function V4a1_LibraryFsmComp_IdleState:onUpdate()
	if not self._nextWalkTime then
		return
	end

	if Time.realtimeSinceStartup < self._nextWalkTime then
		return
	end

	self._nextWalkTime = nil

	local targetX, targetZ = self:unitObj():getRandomWalkTarget()
	local param = {
		targetX = targetX,
		targetZ = targetZ
	}

	self:unitObj():triggerEvent(V4a1_LibraryEnum.Event.BeginWalk, param)
end

function V4a1_LibraryFsmComp_IdleState:onExit()
	self._nextWalkTime = nil
end

return V4a1_LibraryFsmComp_IdleState
