module("modules.configs.excel2json.lua_tower_boss_teach", package.seeall)

slot1 = {
	episodeId = 3,
	name = 6,
	desc = 7,
	teachId = 2,
	firstBonus = 4,
	planId = 5,
	towerId = 1
}
slot2 = {
	"towerId",
	"teachId"
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
