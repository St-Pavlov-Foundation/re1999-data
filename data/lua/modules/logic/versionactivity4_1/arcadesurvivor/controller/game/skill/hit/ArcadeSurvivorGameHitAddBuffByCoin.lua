-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/skill/hit/ArcadeSurvivorGameHitAddBuffByCoin.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.skill.hit.ArcadeSurvivorGameHitAddBuffByCoin", package.seeall)

local ArcadeSurvivorGameHitAddBuffByCoin = class("ArcadeSurvivorGameHitAddBuffByCoin", ArcadeSurvivorGameBaseHit)

function ArcadeSurvivorGameHitAddBuffByCoin:onCtor(params)
	self._perCoin = tonumber(params[1])
	self._buffId = tonumber(params[2])
	self._count = tonumber(params[3]) or 0
end

function ArcadeSurvivorGameHitAddBuffByCoin:_onHit(context, caster, targetList, gridIdDict)
	local totalCount = 0

	if self._perCoin then
		local coin = ArcadeSurvivorGameModel.instance:getCurrencyCount(ArcadeSurvivorEnum.Currency.Coin)
		local addTimes = math.floor(coin / self._perCoin)

		totalCount = addTimes * self._count
	end

	for _, targetMO in ipairs(targetList) do
		local entityType = targetMO:getEntityType()
		local uid = targetMO:getUid()

		ArcadeSurvivorGameController.instance:addBuff2Entity(entityType, uid, self._buffId, totalCount, caster)
	end
end

return ArcadeSurvivorGameHitAddBuffByCoin
