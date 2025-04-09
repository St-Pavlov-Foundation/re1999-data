module("modules.configs.excel2json.lua_tower_hero_trial", package.seeall)

slot1 = {
	season = 1,
	endTime = 3,
	heroIds = 4,
	startTime = 2
}
slot2 = {
	"season"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
