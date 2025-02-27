module("modules.configs.excel2json.lua_fight_monster_skin_idle_map", package.seeall)

slot1 = {
	idleAnimName = 2,
	hitAnimName = 3,
	skinId = 1
}
slot2 = {
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
