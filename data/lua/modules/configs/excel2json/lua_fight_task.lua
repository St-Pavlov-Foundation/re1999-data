module("modules.configs.excel2json.lua_fight_task", package.seeall)

slot1 = {
	taskParam1 = 3,
	taskParam2 = 5,
	sysParam4 = 10,
	taskParam3 = 7,
	condition = 2,
	taskParam4 = 9,
	sysParam2 = 6,
	sysParam1 = 4,
	id = 1,
	sysParam3 = 8
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
