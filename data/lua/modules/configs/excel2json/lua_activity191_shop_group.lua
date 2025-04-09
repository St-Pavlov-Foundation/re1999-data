module("modules.configs.excel2json.lua_activity191_shop_group", package.seeall)

slot1 = {
	type = 4,
	groupType = 5,
	coin = 2,
	id = 1,
	num = 3
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
