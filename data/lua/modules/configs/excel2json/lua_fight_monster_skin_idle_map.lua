module("modules.configs.excel2json.lua_fight_monster_skin_idle_map", package.seeall)

slot1 = {
	freezeAnimName = 4,
	idleAnimName = 2,
	skinId = 1,
	sleepAnimName = 5,
	hitAnimName = 3
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
