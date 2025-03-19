module("modules.configs.excel2json.lua_fight_asfd", package.seeall)

slot1 = {
	replaceRule = 3,
	priority = 10,
	sampleMinHeight = 8,
	audio = 6,
	res = 4,
	sceneEmitterId = 5,
	id = 1,
	unit = 2,
	scale = 7,
	flyPath = 9
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
