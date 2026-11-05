-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookFloorMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookFloorMO", package.seeall)

local ArcadeSurvivorHandBookFloorMO = class("ArcadeSurvivorHandBookFloorMO", ArcadeSurvivorHandBookMO)

function ArcadeSurvivorHandBookFloorMO:getCfg()
	local id = self:getId()

	return ArcadeSurvivorHelper.getEntityCfg(ArcadeSurvivorEnum.EntityType.Floor, id)
end

return ArcadeSurvivorHandBookFloorMO
