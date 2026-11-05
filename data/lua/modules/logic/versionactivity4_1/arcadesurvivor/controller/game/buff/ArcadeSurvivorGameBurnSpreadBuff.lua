-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameBurnSpreadBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameBurnSpreadBuff", package.seeall)

local ArcadeSurvivorGameBurnSpreadBuff = class("ArcadeSurvivorGameBurnSpreadBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameBurnSpreadBuff:onCtor()
	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.BurnSpreadTick)
end

function ArcadeSurvivorGameBurnSpreadBuff:_onTick(context)
	if not context then
		return false
	end

	local buffId = context.buffId
	local targetList = context.targetList

	if not buffId or not targetList then
		return false
	end

	local selfId = self:getId()
	local param = ArcadeSurvivorConfig.instance:getBuffParam(selfId)
	local spreadStack = tonumber(param)

	if not spreadStack or spreadStack <= 0 then
		return false
	end

	local casterMO = self:getUnitMO()

	if not casterMO then
		return false
	end

	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()

		ArcadeSurvivorGameController.instance:addBuff2Entity(entityType, uid, buffId, spreadStack, casterMO)
	end

	return true
end

return ArcadeSurvivorGameBurnSpreadBuff
