-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/work/ArcadeSurvivorRoundBeginWork.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.work.ArcadeSurvivorRoundBeginWork", package.seeall)

local ArcadeSurvivorRoundBeginWork = class("ArcadeSurvivorRoundBeginWork", BaseWork)

function ArcadeSurvivorRoundBeginWork:onStart()
	ArcadeSurvivorGameTriggerController.instance:clearTriggerChain()
	ArcadeSurvivorGameTriggerController.instance:resetTriggerCount()
	ArcadeSurvivorGameController.instance:onRoundBegin()
	self:updateAllyCountdown()
	self:updateFloorCountdown()
	self:onDone(true)
end

function ArcadeSurvivorRoundBeginWork:updateAllyCountdown()
	self:_updateEntityCountdown(ArcadeSurvivorEnum.EntityType.Ally, true)
end

function ArcadeSurvivorRoundBeginWork:updateFloorCountdown()
	self:_updateEntityCountdown(ArcadeSurvivorEnum.EntityType.Floor, false)
end

function ArcadeSurvivorRoundBeginWork:_updateEntityCountdown(entityType, killDirectly)
	local entityMOList = ArcadeSurvivorGameModel.instance:getEntityMOList(entityType)

	if not entityMOList or #entityMOList <= 0 then
		return
	end

	local removeUidList = {}

	for _, entityMO in ipairs(entityMOList) do
		if entityMO:tickRoundCountdown() then
			removeUidList[#removeUidList + 1] = entityMO:getUid()
		end
	end

	for _, entityUid in ipairs(removeUidList) do
		if killDirectly then
			local entityMO = ArcadeSurvivorGameModel.instance:getEntityMO(entityType, entityUid)

			ArcadeSurvivorGameController.instance:takeDamageOneTarget(nil, entityMO, nil, true)
		else
			ArcadeSurvivorGameController.instance:removeEntityOne(entityType, entityUid)
		end
	end
end

function ArcadeSurvivorRoundBeginWork:clearWork()
	return
end

return ArcadeSurvivorRoundBeginWork
