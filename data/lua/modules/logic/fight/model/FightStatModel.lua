﻿-- chunkname: @modules/logic/fight/model/FightStatModel.lua

module("modules.logic.fight.model.FightStatModel", package.seeall)

local FightStatModel = class("FightStatModel", ListScrollModel)

function FightStatModel:onInit()
	self._totalHarm = 0
	self._totalHurt = 0
	self._totalHeal = 0
end

function FightStatModel:setAtkStatInfo(atkStatInfos)
	self._totalHarm = 0
	self._totalHurt = 0
	self._totalHeal = 0

	local statMOList = {}

	for _, statInfo in ipairs(atkStatInfos) do
		if not self:checkShield(statInfo) then
			local entityMO = statInfo.entityMO or FightDataHelper.entityMgr:getById(statInfo.heroUid)

			if statInfo.heroUid == FightASFDDataMgr.EmitterId then
				entityMO = FightDataHelper.ASFDDataMgr:getEmitterEmitterMo()
			end

			if entityMO then
				local statMO = FightStatMO.New()

				statMO:init(statInfo)

				statMO.entityMO = statInfo.entityMO
				statMO.fromOtherFight = statInfo.entityMO and true or false

				table.insert(statMOList, statMO)

				self._totalHarm = self._totalHarm + statMO.harm
				self._totalHurt = self._totalHurt + statMO.hurt
				self._totalHeal = self._totalHeal + statMO.heal
			end
		end
	end

	table.sort(statMOList, function(mo1, mo2)
		if mo1.harm ~= mo2.harm then
			return mo1.harm > mo2.harm
		else
			return mo1.entityId < mo2.entityId
		end
	end)
	self:setList(statMOList)
end

function FightStatModel:checkShield(statInfo)
	if not statInfo then
		return true
	end

	if statInfo.heroUid == FightEntityScene.MySideId or statInfo.heroUid == FightEntityScene.EnemySideId then
		return true
	end

	local entityMo = FightDataHelper.entityMgr:getById(statInfo.heroUid)

	if entityMo and entityMo:isRouge2Music() then
		return true
	end

	return false
end

function FightStatModel:getTotalHarm()
	return self._totalHarm
end

function FightStatModel:getTotalHurt()
	return self._totalHurt
end

function FightStatModel:getTotalHeal()
	return self._totalHeal
end

FightStatModel.instance = FightStatModel.New()

return FightStatModel
