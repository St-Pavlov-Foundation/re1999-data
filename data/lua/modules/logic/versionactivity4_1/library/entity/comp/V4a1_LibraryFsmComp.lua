-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryFsmComp.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryFsmComp", package.seeall)

local V4a1_LibraryFsmComp = class("V4a1_LibraryFsmComp", LibSimpleLuaCompBase)

function V4a1_LibraryFsmComp:ctor(...)
	V4a1_LibraryFsmComp.super.ctor(self, ...)

	self._states = {
		[V4a1_LibraryEnum.State.Idle] = self:newObject(V4a1_LibraryFsmComp_IdleState),
		[V4a1_LibraryEnum.State.Walk] = self:newObject(V4a1_LibraryFsmComp_WalkState)
	}
end

function V4a1_LibraryFsmComp:init(...)
	V4a1_LibraryFsmComp.super.init(self, ...)
	self:changeState(V4a1_LibraryEnum.State.Idle)
end

function V4a1_LibraryFsmComp:beforeDestroy()
	if self._curState then
		self._curState:onExit()
	end

	self._curState = nil
	self._states = nil
end

function V4a1_LibraryFsmComp:curState()
	return self._curState
end

function V4a1_LibraryFsmComp:getState(eV4a1_LibraryEnum_State)
	return self._states and self._states[eV4a1_LibraryEnum_State]
end

function V4a1_LibraryFsmComp:changeState(eV4a1_LibraryEnum_State, param)
	local state = self:getState(eV4a1_LibraryEnum_State)

	if not state then
		return
	end

	if self._curState then
		self._curState:onExit()
	end

	self._curState = state

	state:onEnter(param)
end

function V4a1_LibraryFsmComp:triggerEvent(eventId, param)
	local eType = self:getCurStateType()

	if not eType then
		return
	end

	local Evt = V4a1_LibraryEnum.Event
	local E = V4a1_LibraryEnum.State

	if eventId == Evt.BeginWalk and eType == E.Idle then
		self:changeState(E.Walk, param)
	elseif eventId == Evt.WalkFinish and eType == E.Walk then
		self:changeState(E.Idle, param)
	end
end

function V4a1_LibraryFsmComp:onUpdate()
	if self._curState then
		self._curState:onUpdate()
	end
end

function V4a1_LibraryFsmComp:getCurStateType()
	if self._curState then
		return self._curState:type()
	end
end

return V4a1_LibraryFsmComp
