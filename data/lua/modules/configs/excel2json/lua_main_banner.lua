module("modules.configs.excel2json.lua_main_banner", package.seeall)

slot1 = {
	sortId = 4,
	name = 2,
	jumpId = 5,
	appearanceRole = 7,
	id = 1,
	icon = 3,
	startEnd = 6,
	vanishingRule = 8
}
slot2 = {
	"id"
}
slot3 = {
	name = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
