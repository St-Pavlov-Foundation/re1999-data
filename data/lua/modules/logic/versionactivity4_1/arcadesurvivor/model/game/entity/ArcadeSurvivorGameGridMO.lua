-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/ArcadeSurvivorGameGridMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.ArcadeSurvivorGameGridMO", package.seeall)

local ArcadeSurvivorGameGridMO = class("ArcadeSurvivorGameGridMO", ArcadeSurvivorGameBaseUnitMO)

function ArcadeSurvivorGameGridMO:ctor(gridX, gridY)
	local gridId = ArcadeSurvivorGameHelper.getGridId(gridX, gridY)

	self.id = gridId
	self._entityType = ArcadeSurvivorEnum.EntityType.Grid
	self._id = gridId
	self._uid = gridId

	self:setSize()
	self:setGridPos(gridX, gridY)
	self:setDirection()
end

function ArcadeSurvivorGameGridMO:getIsAlive()
	return true
end

local function logUnsupportedUnitMethod(methodName)
	logError(string.format("ArcadeSurvivorGameGridMO:%s error, grid not support unit ability", methodName))
end

function ArcadeSurvivorGameGridMO:getAttrSet()
	logUnsupportedUnitMethod("getAttrSet")
end

function ArcadeSurvivorGameGridMO:getBuffSet()
	logUnsupportedUnitMethod("getBuffSet")
end

function ArcadeSurvivorGameGridMO:getSkillSet()
	logUnsupportedUnitMethod("getSkillSet")
end

function ArcadeSurvivorGameGridMO:getBuff(buffId)
	logUnsupportedUnitMethod("getBuff")
end

function ArcadeSurvivorGameGridMO:hasSkill(skillId)
	logUnsupportedUnitMethod("hasSkill")
end

function ArcadeSurvivorGameGridMO:getTriggerSkillList(triggerPointWithParam)
	logUnsupportedUnitMethod("getTriggerSkillList")
end

function ArcadeSurvivorGameGridMO:changeHp(value)
	logUnsupportedUnitMethod("changeHp")

	return 0
end

function ArcadeSurvivorGameGridMO:setHp(value)
	logUnsupportedUnitMethod("setHp")

	return 0
end

function ArcadeSurvivorGameGridMO:setDead(isDead)
	logUnsupportedUnitMethod("setDead")
end

function ArcadeSurvivorGameGridMO:changeAttr(attrId, value)
	logUnsupportedUnitMethod("changeAttr")
end

function ArcadeSurvivorGameGridMO:addBuff(buffId, stackCount)
	logUnsupportedUnitMethod("addBuff")
end

function ArcadeSurvivorGameGridMO:removeBuff(buffId, stackCount)
	logUnsupportedUnitMethod("removeBuff")
end

function ArcadeSurvivorGameGridMO:addSkill(skillId)
	logUnsupportedUnitMethod("addSkill")
end

function ArcadeSurvivorGameGridMO:removeSkill(skillId)
	logUnsupportedUnitMethod("removeSkill")
end

function ArcadeSurvivorGameGridMO:onBuffTickEvent(ev, context)
	logUnsupportedUnitMethod("onBuffTickEvent")
end

function ArcadeSurvivorGameGridMO:modifyBuffTickValue(ev, valueType, value)
	logUnsupportedUnitMethod("modifyBuffTickValue")

	return value
end

return ArcadeSurvivorGameGridMO
