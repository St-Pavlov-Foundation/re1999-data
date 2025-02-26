module("modules.configs.excel2json.lua_dice_relic", package.seeall)

slot1 = {
	param = 6,
	name = 2,
	effect = 5,
	id = 1,
	icon = 4,
	desc = 3
}
slot2 = {
	"id"
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
