module("modules.configs.excel2json.lua_fight_she_fa_ignite", package.seeall)

slot1 = {
	id = 1,
	timeline = 3,
	layer = 2
}
slot2 = {
	"id",
	"layer"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
