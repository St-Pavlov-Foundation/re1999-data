module("modules.configs.excel2json.lua_critter_summon", package.seeall)

slot1 = {
	cost = 2,
	serverSummon = 3,
	poolId = 1
}
slot2 = {
	"poolId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
