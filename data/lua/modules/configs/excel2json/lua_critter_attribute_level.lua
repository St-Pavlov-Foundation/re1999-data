module("modules.configs.excel2json.lua_critter_attribute_level", package.seeall)

slot1 = {
	name = 3,
	minValue = 2,
	icon = 4,
	level = 1
}
slot2 = {
	"level"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
