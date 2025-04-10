module("modules.configs.excel2json.lua_activity191_rank", package.seeall)

slot1 = {
	rank = 1,
	fightLevel = 2
}
slot2 = {
	"rank"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
