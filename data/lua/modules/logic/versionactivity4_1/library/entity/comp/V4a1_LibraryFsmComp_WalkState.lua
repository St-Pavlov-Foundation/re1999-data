-- chunkname: @modules/logic/versionactivity4_1/library/entity/comp/V4a1_LibraryFsmComp_WalkState.lua

module("modules.logic.versionactivity4_1.library.entity.comp.V4a1_LibraryFsmComp_WalkState", package.seeall)

local V4a1_LibraryFsmComp_WalkState = class("V4a1_LibraryFsmComp_WalkState", V4a1_LibraryFsmComp_StateBase)

function V4a1_LibraryFsmComp_WalkState:type()
	return V4a1_LibraryEnum.State.Walk
end

function V4a1_LibraryFsmComp_WalkState:ctor(...)
	V4a1_LibraryFsmComp_WalkState.super.ctor(self, ...)
end

function V4a1_LibraryFsmComp_WalkState:onEnter(param)
	if param then
		self._targetX = param.targetX
		self._targetZ = param.targetZ
	else
		self._targetX, self._targetZ = self:unitObj():getRandomWalkTarget()
	end

	local pos = self:unitObj():getPosition()
	local dirX = self._targetX - pos.x
	local dirZ = self._targetZ - pos.z
	local length = math.sqrt(dirX * dirX + dirZ * dirZ)

	if length > 0.01 then
		self._dirX = dirX / length
		self._dirZ = dirZ / length
	else
		self._dirX = 1
		self._dirZ = 0
	end

	self:unitObj():setSpineLookDir(self._dirX >= 0 and SpineLookDir.Right or SpineLookDir.Left)
	self:spineComp():playState(V4a1_LibraryEnum.SpineAnim.Walk)
end

function V4a1_LibraryFsmComp_WalkState:onUpdate()
	local pos = self:unitObj():getPosition()
	local moveStep = self:unitObj():getCharSpeedByCO() * UnityEngine.Time.deltaTime
	local offsetX = self._targetX - pos.x
	local offsetZ = self._targetZ - pos.z
	local distance = math.sqrt(offsetX * offsetX + offsetZ * offsetZ)

	if distance <= moveStep or distance <= 0.01 then
		self:unitObj():setPosition(self._targetX, 0, self._targetZ)
		self:unitObj():triggerEvent(V4a1_LibraryEnum.Event.WalkFinish)

		return
	end

	local dirX = offsetX / distance
	local dirZ = offsetZ / distance

	self:unitObj():setPosition(pos.x + dirX * moveStep, 0, pos.z + dirZ * moveStep)
end

function V4a1_LibraryFsmComp_WalkState:onExit()
	self._targetX = nil
	self._targetZ = nil
	self._dirX = nil
	self._dirZ = nil
end

return V4a1_LibraryFsmComp_WalkState
