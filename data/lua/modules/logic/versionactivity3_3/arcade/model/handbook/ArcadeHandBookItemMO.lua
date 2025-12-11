-- chunkname: @modules/logic/versionactivity3_3/arcade/model/handbook/ArcadeHandBookItemMO.lua

module("modules.logic.versionactivity3_3.arcade.model.handbook.ArcadeHandBookItemMO", package.seeall)

local ArcadeHandBookItemMO = class("ArcadeHandBookItemMO", ArcadeHandBookMO)

function ArcadeHandBookItemMO:getDesc()
	local desc = self.co.describe

	if not string.nilorempty(desc) then
		desc = ArcadeConfig.instance:getCollectionDesc(self.co.id, true)
	end

	return desc or ""
end

return ArcadeHandBookItemMO
