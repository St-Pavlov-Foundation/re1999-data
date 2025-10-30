﻿-- chunkname: @modules/logic/rouge2/backpack/model/rpcmo/Rouge2_BagMO.lua

module("modules.logic.rouge2.backpack.model.rpcmo.Rouge2_BagMO", package.seeall)

local Rouge2_BagMO = pureTable("Rouge2_BagMO")

function Rouge2_BagMO:init(info)
	self._bagType = info.bagType

	self:updateItems(info.items)
end

function Rouge2_BagMO:getItemList()
	return self._itemList
end

function Rouge2_BagMO:getItem(uid)
	return self._uid2ItemMap and self._uid2ItemMap[uid]
end

function Rouge2_BagMO:getItemListByItemId(itemId)
	return self._itemId2ItemList and self._itemId2ItemList[itemId]
end

function Rouge2_BagMO:removeItem(itemInfo)
	local uid = itemInfo.uid
	local itemMo = self:getItem(uid)

	if not itemMo then
		return
	end

	self._uid2ItemMap[uid] = nil

	tabletool.removeValue(self._itemList, itemMo)

	local itemId = itemMo:getItemId()
	local itemList = self._itemId2ItemList[itemId]

	if itemList ~= nil then
		tabletool.removeValue(itemList, itemMo)
	end
end

function Rouge2_BagMO:updateItems(items)
	self._itemList = {}
	self._uid2ItemMap = {}
	self._itemId2ItemList = {}

	if items then
		for _, item in ipairs(items) do
			self:updateItem(item)
		end
	end
end

function Rouge2_BagMO:updateItem(itemInfo)
	local uid = itemInfo.uid
	local itemMo = self:getItem(uid)

	if not itemMo then
		itemMo = Rouge2_BagItemMO.New()
		self._uid2ItemMap[uid] = itemMo

		table.insert(self._itemList, itemMo)

		local itemId = itemInfo.itemId
		local itemList = self._itemId2ItemList[itemId] or {}

		table.insert(itemList, itemMo)

		self._itemId2ItemList[itemId] = itemList
	end

	itemMo:init(itemInfo)
end

return Rouge2_BagMO
