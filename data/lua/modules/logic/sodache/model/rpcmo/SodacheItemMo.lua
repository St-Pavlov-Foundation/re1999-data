-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheItemMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheItemMo", package.seeall)

local SodacheItemMo = pureTable("SodacheItemMo")

function SodacheItemMo:init(data)
	self.uid = data.uid
	self.configId = data.configId
	self.count = data.count
	self.itemType = SodacheEnum.ItemType.Unknown

	if self.configId >= 10000000 and self.configId < 20000000 then
		self.itemType = SodacheEnum.ItemType.Item
	elseif self.configId >= 20000000 and self.configId < 30000000 then
		self.itemType = SodacheEnum.ItemType.Card
	end

	self.itemCo = SodacheConfig.instance:getItemCo(self.itemType, self.configId)

	if not self.itemCo then
		logError("道具配置不存在!cfgId:" .. self.configId)
	end
end

function SodacheItemMo:toCardMo(source)
	local cardMo = SodacheCardMo.New()

	cardMo:init(self, source)

	return cardMo
end

return SodacheItemMo
