-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/game/entity/set/ArcadeSurvivorGameBuffSet.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.game.entity.set.ArcadeSurvivorGameBuffSet", package.seeall)

local ArcadeSurvivorGameBuffSet = class("ArcadeSurvivorGameBuffSet", ArcadeSurvivorGameBaseSet)

function ArcadeSurvivorGameBuffSet:onCtor()
	self._buffDict = {}
	self._buffList = {}
end

function ArcadeSurvivorGameBuffSet:addBuff2Set(buffId, stackCount, casterMO)
	local cfg = ArcadeSurvivorConfig.instance:getBuffCfg(buffId, true)

	if not cfg or stackCount <= 0 then
		return
	end

	local buff = self:getBuffInSet(buffId)

	if buff then
		buff:addStackCount(stackCount)
	else
		local buffType = ArcadeSurvivorConfig.instance:getBuffType(buffId)
		local cls = ArcadeSurvivorGameEnum.BuffClsMap[buffType]

		if not cls then
			logError(string.format("ArcadeSurvivorGameBuffSet:addBuff2Set buffId:%s buffType %s not found", buffId, buffType))

			return
		end

		local unitMO = self:getUnitMO()

		buff = cls.New(buffId, stackCount, unitMO, casterMO)
		self._buffDict[buffId] = buff
		self._buffList[#self._buffList + 1] = buff
	end
end

function ArcadeSurvivorGameBuffSet:removeBuffInSet(buffId, stackCount)
	local buff = self:getBuffInSet(buffId)

	if not buff then
		return
	end

	local subCount = stackCount or buff:getStackCount()

	buff:subStackCount(subCount)

	local isActive = buff:getIsActive()

	if not isActive then
		self._buffDict[buffId] = nil

		tabletool.removeValue(self._buffList, buff)
	end
end

function ArcadeSurvivorGameBuffSet:getBuffInSet(buffId)
	return buffId and self._buffDict[buffId]
end

function ArcadeSurvivorGameBuffSet:getBuffList()
	return self._buffList
end

return ArcadeSurvivorGameBuffSet
