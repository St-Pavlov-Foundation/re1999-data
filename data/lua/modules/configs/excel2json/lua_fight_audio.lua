module("modules.configs.excel2json.lua_fight_audio", package.seeall)

slot1 = {
	id = 1,
	bankName = 3,
	weapon = 4,
	eventName = 2
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
