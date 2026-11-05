-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/ArcadeSurvivorGameSkillController.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.ArcadeSurvivorGameSkillController", package.seeall)

local ArcadeSurvivorGameSkillController = class("ArcadeSurvivorGameSkillController", BaseController)

function ArcadeSurvivorGameSkillController:onInit()
	return
end

function ArcadeSurvivorGameSkillController:onInitFinish()
	return
end

function ArcadeSurvivorGameSkillController:addConstEvents()
	return
end

function ArcadeSurvivorGameSkillController:reInit()
	return
end

function ArcadeSurvivorGameSkillController:castSkill(entityType, uid, skillId)
	local mo = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, uid)

	if not mo or mo:getIsDead() then
		return false
	end

	local skillStackList = mo:getSkillStackList(skillId)

	if not skillStackList or #skillStackList <= 0 then
		return false
	end

	local result = false

	for _, skill in ipairs(skillStackList) do
		local context = ArcadeSurvivorGameTriggerContext.New(ArcadeSurvivorGameEnum.TriggerPoint.None, nil, mo)

		result = skill:activeCast(context) or result
	end

	return result
end

ArcadeSurvivorGameSkillController.instance = ArcadeSurvivorGameSkillController.New()

return ArcadeSurvivorGameSkillController
