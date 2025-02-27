module("modules.configs.excel2json.lua_rouge_map_rule", package.seeall)

slot1 = {
	group = 3,
	id = 1,
	type = 2,
	addCollection = 4,
	desc = 5
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
