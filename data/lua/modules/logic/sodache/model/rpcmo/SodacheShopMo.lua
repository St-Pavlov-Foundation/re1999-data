-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheShopMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheShopMo", package.seeall)

local SodacheShopMo = pureTable("SodacheShopMo")

function SodacheShopMo:init(data)
	self.id = data.id
	self.items, self.itemsMap = GameUtil.rpcInfosToListAndMap(data.items, SodacheShopItemMo, "id", self.itemsMap)
	self.itemsByItemTypes = {}

	for i, v in ipairs(self.items) do
		local type = v.itemType

		if type then
			self.itemsByItemTypes[type] = self.itemsByItemTypes[type] or {}

			table.insert(self.itemsByItemTypes[type], v)
		end
	end

	self.shopCo = lua_sodache_shop.configDict[self.id]
end

function SodacheShopMo:getShopType()
	return self.shopCo and self.shopCo.type
end

return SodacheShopMo
