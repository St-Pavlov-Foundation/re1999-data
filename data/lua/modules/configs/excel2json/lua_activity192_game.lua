module("modules.configs.excel2json.lua_activity192_game", package.seeall)

slot1 = {
	cubeOpenAnim = 4,
	cubeSwitchAnim = 5,
	removeCount = 3,
	panelImage = 6,
	id = 1,
	scenePath = 7,
	maps = 2
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
