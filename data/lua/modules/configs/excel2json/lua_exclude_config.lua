module("modules.configs.excel2json.lua_exclude_config", package.seeall)

slot1 = {
	row_sel = 4,
	json_file = 3,
	mode = 5,
	params = 6,
	id = 1,
	version = 2,
	onornot = 7
}
slot2 = {
	"id"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
