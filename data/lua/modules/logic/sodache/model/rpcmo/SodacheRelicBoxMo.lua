-- chunkname: @modules/logic/sodache/model/rpcmo/SodacheRelicBoxMo.lua

module("modules.logic.sodache.model.rpcmo.SodacheRelicBoxMo", package.seeall)

local SodacheRelicBoxMo = pureTable("SodacheRelicBoxMo")

function SodacheRelicBoxMo:init(data)
	self.relics, self.relicMap = GameUtil.rpcInfosToListAndMap(data.relics, SodacheRelicMo, "id")

	for _, config in ipairs(lua_sodache_upgrade.configList) do
		local relicId = config.id

		if config.level == 1 and not self:getRelicMo(relicId) then
			local mo = SodacheRelicMo.New()

			mo:init({
				level = 0,
				id = relicId
			})

			self.relicMap[relicId] = mo
			self.relics[#self.relics + 1] = mo
		end
	end

	if isDebugBuild then
		for i = #self.relics, 1, -1 do
			local mo = self.relics[i]

			if not mo.itemCo or not mo.relicCo then
				table.remove(self.relics, i)

				self.relicMap[mo.id] = nil
			end
		end
	end

	table.sort(self.relics, function(a, b)
		local configA = a.itemCo
		local configB = b.itemCo

		if configA.quality == configB.quality then
			return configA.id < configB.id
		else
			return configA.quality < configB.quality
		end
	end)
end

function SodacheRelicBoxMo:getRelicMo(relicId)
	return self.relicMap[relicId]
end

function SodacheRelicBoxMo:getRelicLv(relicId)
	return self.relicMap[relicId] and self.relicMap[relicId].level or 0
end

function SodacheRelicBoxMo:getRelicNeedCount(relicId)
	local configs = lua_sodache_upgrade.configDict[relicId]

	if not configs then
		return 0
	end

	local curLv = self:getRelicLv(relicId)
	local needCount = 0

	for i = curLv + 1, #configs do
		local cost = configs[i].cost

		if not string.nilorempty(cost) then
			local arr = GameUtil.splitString2(cost, true, "&", ":")

			for _, v in ipairs(arr) do
				if v[1] == relicId then
					needCount = needCount + v[2]
				end
			end
		end
	end

	return needCount
end

return SodacheRelicBoxMo
