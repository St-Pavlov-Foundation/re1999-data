module("modules.configs.excel2json.lua_activity191_relation", package.seeall)

slot1 = {
	activeNum = 6,
	name = 3,
	levelDesc = 8,
	tag = 2,
	tagBg = 5,
	desc = 7,
	effects = 9,
	id = 1,
	icon = 10,
	level = 4
}
slot2 = {
	"id"
}
slot3 = {
	name = 1,
	levelDesc = 3,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
