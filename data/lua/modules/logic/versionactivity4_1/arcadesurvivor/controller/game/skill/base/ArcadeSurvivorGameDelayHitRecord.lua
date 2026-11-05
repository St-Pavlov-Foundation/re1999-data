-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/base/ArcadeSurvivorGameDelayHitRecord.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.base.ArcadeSurvivorGameDelayHitRecord", package.seeall)

local ArcadeSurvivorGameDelayHitRecord = class("ArcadeSurvivorGameDelayHitRecord")

function ArcadeSurvivorGameDelayHitRecord:ctor(skillId, skillUid, triggerIndex, context, delayTurn, gridIdDict, needAlert, effectIndex)
	self.delayContext = context
	self.remainTurn = delayTurn
	self.gridIdDict = gridIdDict
	self.needAlert = needAlert

	local caster = context and context:getCaster()

	self.entityType = caster and caster:getEntityType()
	self.uid = caster and caster:getUid()
	self.skillId = skillId
	self.skillUid = skillUid
	self.triggerIndex = triggerIndex
	self.effectIndex = effectIndex
end

function ArcadeSurvivorGameDelayHitRecord:tick()
	self.remainTurn = self.remainTurn - 1

	return self.remainTurn <= 0
end

function ArcadeSurvivorGameDelayHitRecord:getDelayContext()
	return self.delayContext
end

function ArcadeSurvivorGameDelayHitRecord:getGridIdDict()
	return self.gridIdDict
end

function ArcadeSurvivorGameDelayHitRecord:getNeedAlert()
	return self.needAlert
end

function ArcadeSurvivorGameDelayHitRecord:getRemainTurn()
	return self.remainTurn
end

function ArcadeSurvivorGameDelayHitRecord:getEntityType()
	return self.entityType
end

function ArcadeSurvivorGameDelayHitRecord:getUid()
	return self.uid
end

function ArcadeSurvivorGameDelayHitRecord:getSkillId()
	return self.skillId
end

function ArcadeSurvivorGameDelayHitRecord:getSkillUid()
	return self.skillUid
end

function ArcadeSurvivorGameDelayHitRecord:getTriggerIndex()
	return self.triggerIndex
end

function ArcadeSurvivorGameDelayHitRecord:getEffectIndex()
	return self.effectIndex
end

return ArcadeSurvivorGameDelayHitRecord
