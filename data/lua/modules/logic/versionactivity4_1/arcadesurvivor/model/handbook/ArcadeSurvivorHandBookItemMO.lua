-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/handbook/ArcadeSurvivorHandBookItemMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.handbook.ArcadeSurvivorHandBookItemMO", package.seeall)

local ArcadeSurvivorHandBookItemMO = class("ArcadeSurvivorHandBookItemMO", ArcadeSurvivorHandBookMO)

function ArcadeSurvivorHandBookItemMO:getCfg()
	local id = self:getId()

	return ArcadeSurvivorConfig.instance:getCollectionCfg(id, true)
end

return ArcadeSurvivorHandBookItemMO
