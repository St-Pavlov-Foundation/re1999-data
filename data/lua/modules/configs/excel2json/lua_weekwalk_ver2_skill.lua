module("modules.configs.excel2json.lua_weekwalk_ver2_skill", package.seeall)

slot1 = {
	rules = 5,
	name = 2,
	id = 1,
	icon = 3,
	desc = 4
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
