module("modules.configs.excel2json.lua_stress_identity", package.seeall)

slot1 = {
	param = 6,
	effect = 5,
	name = 2,
	typeParam = 4,
	isNoShow = 7,
	desc = 8,
	id = 1,
	uiType = 9,
	identity = 3
}
slot2 = {
	"id"
}
slot3 = {
	desc = 2,
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
