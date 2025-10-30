﻿-- chunkname: @modules/logic/survival/model/map/SurvivalPlayerMo.lua

module("modules.logic.survival.model.map.SurvivalPlayerMo", package.seeall)

local SurvivalPlayerMo = pureTable("SurvivalPlayerMo")

function SurvivalPlayerMo:init(data)
	self.id = 0
	self.dir = data.position.dir
	self.pos = SurvivalHexNode.New(data.position.hex.q, data.position.hex.r)
	self.explored = {}

	for k, v in ipairs(data.explored) do
		SurvivalHelper.instance:addNodeToDict(self.explored, v)
	end

	self.canExplored = {}

	for k, v in ipairs(data.canExplored) do
		SurvivalHelper.instance:addNodeToDict(self.canExplored, v)
	end
end

function SurvivalPlayerMo:getWorldPos()
	return SurvivalHelper.instance:hexPointToWorldPoint(self.pos.q, self.pos.r)
end

function SurvivalPlayerMo:getResPath()
	local constId = SurvivalEnum.ConstId.PlayerRes
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local subType = sceneMo:getBlockTypeByPos(self.pos)

	if subType == SurvivalEnum.UnitSubType.Ice and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Ice) > 0 then
		constId = SurvivalEnum.ConstId.Vehicle_Ice
	elseif subType == SurvivalEnum.UnitSubType.Magma and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Magma) > 0 then
		constId = SurvivalEnum.ConstId.Vehicle_Magma
	elseif subType == SurvivalEnum.UnitSubType.Miasma and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Miasma) > 0 then
		constId = SurvivalEnum.ConstId.Vehicle_Miasma
	elseif subType == SurvivalEnum.UnitSubType.Morass and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Morass) > 0 then
		constId = SurvivalEnum.ConstId.Vehicle_Morass
	elseif subType == SurvivalEnum.UnitSubType.Water then
		if weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Water) > 0 then
			constId = SurvivalEnum.ConstId.Vehicle_Water
		else
			constId = SurvivalEnum.ConstId.Vehicle_WaterNormal
		end
	end

	return SurvivalConfig.instance:getConstValue(constId)
end

function SurvivalPlayerMo:isDefaultModel()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local subType = sceneMo:getBlockTypeByPos(self.pos)

	if subType == SurvivalEnum.UnitSubType.Ice and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Ice) > 0 then
		return false
	elseif subType == SurvivalEnum.UnitSubType.Magma and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Magma) > 0 then
		return false
	elseif subType == SurvivalEnum.UnitSubType.Miasma and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Miasma) > 0 then
		return false
	elseif subType == SurvivalEnum.UnitSubType.Morass and weekInfo:getAttr(SurvivalEnum.AttrType.Vehicle_Morass) > 0 then
		return false
	elseif subType == SurvivalEnum.UnitSubType.Water then
		return false
	end

	return true
end

return SurvivalPlayerMo
