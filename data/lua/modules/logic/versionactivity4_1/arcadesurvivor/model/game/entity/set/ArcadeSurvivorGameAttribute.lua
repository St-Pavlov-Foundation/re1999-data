-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/set/ArcadeSurvivorGameAttribute.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.set.ArcadeSurvivorGameAttribute", package.seeall)

local ArcadeSurvivorGameAttribute = class("ArcadeSurvivorGameAttribute")

function ArcadeSurvivorGameAttribute:ctor(id, base)
	self._id = id
	self._base = tonumber(base) or 0
	self._rate = 0
	self._increase = 0

	self:_calVal()
end

function ArcadeSurvivorGameAttribute:getId()
	return self._id
end

function ArcadeSurvivorGameAttribute:getValue()
	return self._val
end

function ArcadeSurvivorGameAttribute:getBase()
	return self._base
end

function ArcadeSurvivorGameAttribute:getRate()
	return self._rate
end

function ArcadeSurvivorGameAttribute:getIncrease()
	return self._increase
end

function ArcadeSurvivorGameAttribute:_calVal()
	local rate = 1 + self._rate / ArcadeSurvivorEnum.Const.PermillageBase
	local value = math.ceil(self._base * rate + self._increase)
	local attrId = self:getId()
	local min = ArcadeSurvivorConfig.instance:getAttributeMin(attrId, true)
	local max = ArcadeSurvivorConfig.instance:getAttributeMax(attrId, true)

	if max <= 0 then
		self._val = math.max(min, value)
	else
		self._val = Mathf.Clamp(value, min, max)
	end
end

function ArcadeSurvivorGameAttribute:setRate(rate)
	local numRate = tonumber(rate)

	if not numRate then
		numRate = 0

		logError(string.format("ArcadeSurvivorGameAttribute:setRate error, rate:%s is not a number", rate))
	end

	self._rate = numRate

	self:_calVal()
end

function ArcadeSurvivorGameAttribute:setIncrease(increase)
	local numIncrease = tonumber(increase)

	if not numIncrease then
		logError(string.format("ArcadeSurvivorGameAttribute:setIncrease error, increase:%s is not a number", increase))

		return
	end

	self._increase = numIncrease

	self:_calVal()
end

function ArcadeSurvivorGameAttribute:changeIncrease(increase)
	local numIncrease = tonumber(increase)

	if not numIncrease then
		logError(string.format("ArcadeSurvivorGameAttribute:changeIncrease error, increase:%s is not a number", increase))

		return
	end

	self._increase = self._increase + numIncrease

	self:_calVal()
end

function ArcadeSurvivorGameAttribute:reset()
	self._rate = 0
	self._increase = 0

	self:_calVal()
end

return ArcadeSurvivorGameAttribute
