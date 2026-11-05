-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameBurnBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameBurnBuff", package.seeall)

local ArcadeSurvivorGameBurnBuff = class("ArcadeSurvivorGameBurnBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameBurnBuff:onCtor()
	local unitMO = self:getUnitMO()
	local targetEntityType = unitMO and unitMO:getEntityType()

	if targetEntityType then
		local selectorParam = {
			ArcadeSurvivorGameEnum.SelectorType.Rect,
			targetEntityType,
			ArcadeSurvivorGameEnum.Const.BurnBuffRange
		}

		self._targetSelector = ArcadeSurvivorGameSkillFactory.createSelectorByParam(selectorParam)
	end

	self:_setTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.TurnEnd)
end

function ArcadeSurvivorGameBurnBuff:_onTick(context)
	local unitMO = self:getUnitMO()
	local isAlive = unitMO and unitMO:getIsAlive()

	if not self._targetSelector or not isAlive then
		return false
	end

	if unitMO:getIsOffBoard() then
		return false
	end

	local gridX, gridY = unitMO:getGridPos()
	local direction = unitMO:getDirection()
	local targetList = self._targetSelector:findTarget(gridX, gridY, direction)

	ArcadeSurvivorGameController.instance:takeDamage(nil, targetList, ArcadeSurvivorGameEnum.Const.BurnBuffDamage)

	local casterMO = self:getCasterMO()

	if casterMO then
		local buffContext = {
			buffId = self:getId(),
			targetList = targetList
		}

		casterMO:onBuffTickEvent(ArcadeSurvivorGameEnum.BuffTickEvent.BurnSpreadTick, buffContext)
	end

	return true
end

return ArcadeSurvivorGameBurnBuff
