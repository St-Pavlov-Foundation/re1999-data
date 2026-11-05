-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameBaseBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameBaseBuff", package.seeall)

local ArcadeSurvivorGameBaseBuff = class("ArcadeSurvivorGameBaseBuff")

function ArcadeSurvivorGameBaseBuff:ctor(buffId, stackCount, unitMO, casterMO)
	self._id = buffId
	self._unitMO = unitMO
	self._casterMO = casterMO
	self._tickEvent = nil
	self._valueType = nil
	self._consumedDuration = 0
	self._type = ArcadeSurvivorConfig.instance:getBuffType(self._id)
	self._isConsumeStack = ArcadeSurvivorConfig.instance:getBuffIsSubStack(self._id)
	self._duration = ArcadeSurvivorConfig.instance:getBuffDuration(self._id)
	self._isPermanent = not self._duration or self._duration <= 0

	self:onCtor()
	self:addStackCount(stackCount)
end

function ArcadeSurvivorGameBaseBuff:_setTickEvent(ev)
	self._tickEvent = ev
end

function ArcadeSurvivorGameBaseBuff:_setValueType(valueType)
	self._valueType = valueType
end

function ArcadeSurvivorGameBaseBuff:addStackCount(stackCount)
	local addCount = stackCount or 1

	if addCount <= 0 then
		return
	end

	local id = self:getId()
	local oldStackCount = self._stackCount or 0
	local newStackCount = oldStackCount + addCount
	local maxStackCount = ArcadeSurvivorConfig.instance:getBuffMaxStack(id)

	if maxStackCount and maxStackCount > 0 then
		newStackCount = math.min(newStackCount, maxStackCount)
	end

	self._stackCount = newStackCount
	self._consumedDuration = 0

	local addStackCount = newStackCount - oldStackCount

	self:_onAddStack(addStackCount)
	self:_checkActive()

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.BuffUp
	local unitMO = self:getUnitMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, self:getId(), unitMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, self:getId(), context)
end

function ArcadeSurvivorGameBaseBuff:subStackCount(stackCount)
	local subCount = stackCount or 1

	if subCount <= 0 then
		return
	end

	local oldStackCount = self._stackCount or 0
	local newStackCount = oldStackCount - subCount

	self._stackCount = math.max(0, newStackCount)

	local realSubStackCount = oldStackCount - newStackCount

	self:_onSubStack(realSubStackCount)
	self:_checkActive()

	local triggerPoint = ArcadeSurvivorGameEnum.TriggerPoint.BuffDown
	local unitMO = self:getUnitMO()
	local context = ArcadeSurvivorGameTriggerContext.New(triggerPoint, self:getId(), unitMO)

	ArcadeSurvivorGameTriggerController.instance:trigger(triggerPoint, self:getId(), context)
end

function ArcadeSurvivorGameBaseBuff:onReceiveTickEvent(ev, context)
	local isActive = self:getIsActive()

	if not isActive then
		return
	end

	if not self._tickEvent or self._tickEvent ~= ev then
		return
	end

	local result = self:_onTick(context)

	if result and self._isConsumeStack then
		self:_consumeStack()
	end
end

function ArcadeSurvivorGameBaseBuff:modifyTickValue(ev, valueType, value)
	local isActive = self:getIsActive()

	if not isActive then
		return value
	end

	if not self._tickEvent or self._tickEvent ~= ev then
		return value
	end

	if not self._valueType or self._valueType ~= valueType then
		return value
	end

	local result, newVal = self:_onModifyValue(value)

	if result and self._isConsumeStack then
		self:_consumeStack()
	end

	return newVal
end

function ArcadeSurvivorGameBaseBuff:_consumeStack()
	local consumeStackCount = self:_getConsumeStackCount()
	local newStack = (self._stackCount or 0) - consumeStackCount

	self._stackCount = math.max(0, newStack)

	self:_checkActive()
end

function ArcadeSurvivorGameBaseBuff:onTurnEnd()
	if self._isPermanent then
		return
	end

	self._consumedDuration = self._consumedDuration + 1

	if self._consumedDuration >= self._duration then
		local curStack = self:getStackCount()

		self:subStackCount(curStack)
	else
		self:_checkActive()
	end
end

function ArcadeSurvivorGameBaseBuff:_checkActive()
	local haveDuration = true

	if not self._isPermanent then
		haveDuration = self._consumedDuration < self._duration
	end

	if haveDuration and self._stackCount > 0 then
		self:_active()
	else
		self:_expire()
	end
end

function ArcadeSurvivorGameBaseBuff:_active()
	if self._isActive then
		return
	end

	self._isActive = true

	self:_onActive()
end

function ArcadeSurvivorGameBaseBuff:_expire()
	if not self._isActive then
		return
	end

	self._isActive = false
	self._stackCount = 0
	self._consumedDuration = 0

	self:_onExpire()

	local unitMO = self:getUnitMO()

	if unitMO then
		local entityType = unitMO:getEntityType()
		local uid = unitMO:getUid()
		local buffId = self:getId()

		ArcadeSurvivorGameController.instance:onBuffExpire(entityType, uid, buffId)
	end
end

function ArcadeSurvivorGameBaseBuff:getId()
	return self._id
end

function ArcadeSurvivorGameBaseBuff:getStackCount()
	return self._stackCount or 0
end

function ArcadeSurvivorGameBaseBuff:getIsPermanent()
	return self._isPermanent == true
end

function ArcadeSurvivorGameBaseBuff:getRemainRound()
	if self:getIsPermanent() then
		return 0
	end

	return math.max(0, (self._duration or 0) - (self._consumedDuration or 0))
end

function ArcadeSurvivorGameBaseBuff:getUnitMO()
	return self._unitMO
end

function ArcadeSurvivorGameBaseBuff:getCasterMO()
	return self._casterMO
end

function ArcadeSurvivorGameBaseBuff:getIsActive()
	return self._isActive
end

function ArcadeSurvivorGameBaseBuff:onCtor()
	return
end

function ArcadeSurvivorGameBaseBuff:_onTick(context)
	return false
end

function ArcadeSurvivorGameBaseBuff:_onModifyValue(value)
	return false, value
end

function ArcadeSurvivorGameBaseBuff:_onAddStack(addStackCount)
	return
end

function ArcadeSurvivorGameBaseBuff:_onSubStack(subStackCount)
	return
end

function ArcadeSurvivorGameBaseBuff:_onActive()
	return
end

function ArcadeSurvivorGameBaseBuff:_onExpire()
	return
end

function ArcadeSurvivorGameBaseBuff:_getConsumeStackCount()
	return ArcadeSurvivorGameEnum.Const.DefaultConsumeBuffStack
end

return ArcadeSurvivorGameBaseBuff
