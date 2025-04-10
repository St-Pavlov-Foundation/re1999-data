module("modules.configs.excel2json.lua_activity191_ex_level", package.seeall)

slot1 = {
	desc = 3,
	monsterId = 1,
	skillLevel = 2
}
slot2 = {
	"monsterId",
	"skillLevel"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
