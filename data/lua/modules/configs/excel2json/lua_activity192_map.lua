module("modules.configs.excel2json.lua_activity192_map", package.seeall)

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = uv0.json_parse(slot0)
	end,
	json_parse = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			table.insert(slot1, slot7)

			if not slot2[slot7.mapId] then
				slot2[slot7.mapId] = {}
			end

			slot8[slot7.componentId] = slot7
		end

		return slot1, slot2
	end
}
