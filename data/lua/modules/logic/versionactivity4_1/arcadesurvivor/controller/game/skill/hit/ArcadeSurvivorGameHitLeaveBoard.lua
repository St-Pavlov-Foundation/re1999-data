-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitLeaveBoard.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitLeaveBoard", package.seeall)

local ArcadeSurvivorGameHitLeaveBoard = class("ArcadeSurvivorGameHitLeaveBoard", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitLeaveBoard:_onHit(context, caster)
	local result = ArcadeSurvivorGameController.instance:leaveBoard(caster:getEntityType(), caster:getUid())

	return false, result
end

return ArcadeSurvivorGameHitLeaveBoard
