-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/controller/game/buff/ArcadeSurvivorGameChangeAttrBuff.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.controller.game.buff.ArcadeSurvivorGameChangeAttrBuff", package.seeall)

local ArcadeSurvivorGameChangeAttrBuff = class("ArcadeSurvivorGameChangeAttrBuff", ArcadeSurvivorGameBaseBuff)

function ArcadeSurvivorGameChangeAttrBuff:onCtor()
	self._attrChangeDict = {}
	self._attrIdList = {}
	self._appliedCount = 0

	local id = self:getId()
	local param = ArcadeSurvivorConfig.instance:getBuffParam(id)

	if not string.nilorempty(param) then
		local paramArr = GameUtil.splitString2(param, true, "#", ":")

		for i = 1, #paramArr do
			local attrData = paramArr[i]
			local attrId = tonumber(attrData[1])
			local value = tonumber(attrData[2])

			if attrId and value then
				if not self._attrChangeDict[attrId] then
					self._attrIdList[#self._attrIdList + 1] = attrId
				end

				self._attrChangeDict[attrId] = value
			end
		end
	end
end

function ArcadeSurvivorGameChangeAttrBuff:_onAddStack(addStackCount)
	if addStackCount <= 0 then
		return
	end

	local unitMO = self:getUnitMO()

	if not unitMO then
		return
	end

	local changeAttrDict = {}

	for attrId, value in pairs(self._attrChangeDict) do
		changeAttrDict[attrId] = value * addStackCount
	end

	local entityType = unitMO:getEntityType()
	local uid = unitMO:getUid()

	self._appliedCount = self._appliedCount + addStackCount

	ArcadeSurvivorGameController.instance:changeEntityAttrs(entityType, uid, changeAttrDict, self._attrIdList)
end

function ArcadeSurvivorGameChangeAttrBuff:_onExpire()
	local unitMO = self:getUnitMO()

	if not unitMO then
		return
	end

	local changeAttrDict = {}
	local attrIdList = {}

	for index = #self._attrIdList, 1, -1 do
		local attrId = self._attrIdList[index]

		if attrId ~= ArcadeSurvivorEnum.Attribute.respawnTimes then
			changeAttrDict[attrId] = -self._attrChangeDict[attrId] * self._appliedCount
			attrIdList[#attrIdList + 1] = attrId
		end
	end

	local entityType = unitMO:getEntityType()
	local uid = unitMO:getUid()

	self._appliedCount = 0

	ArcadeSurvivorGameController.instance:changeEntityAttrs(entityType, uid, changeAttrDict, attrIdList)
end

return ArcadeSurvivorGameChangeAttrBuff
