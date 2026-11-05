-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookCollectionMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookCollectionMO", package.seeall)

local ArcadeSurvivorHandBookCollectionMO = class("ArcadeSurvivorHandBookCollectionMO")

function ArcadeSurvivorHandBookCollectionMO:ctor(id)
	self.id = id
end

function ArcadeSurvivorHandBookCollectionMO:getId()
	return self.id
end

function ArcadeSurvivorHandBookCollectionMO:getName()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCollectionName(id)
end

function ArcadeSurvivorHandBookCollectionMO:getDesc()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCollectionDesc(id)
end

function ArcadeSurvivorHandBookCollectionMO:getIcon()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCollectionIcon(id)
end

function ArcadeSurvivorHandBookCollectionMO:getCount()
	local mo = ArcadeSurvivorHandBookModel.instance:getMOByTypeId(ArcadeSurvivorHallEnum.HandBookType.Item, self.id)

	return mo and mo:getCount() or 1
end

return ArcadeSurvivorHandBookCollectionMO
