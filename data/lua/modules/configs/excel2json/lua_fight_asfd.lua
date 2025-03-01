module("modules.configs.excel2json.lua_fight_asfd", package.seeall)

slot1 = {
	replaceRule = 3,
	priority = 9,
	sampleMinHeight = 7,
	audio = 5,
	res = 4,
	id = 1,
	unit = 2,
	scale = 6,
	flyPath = 8
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
