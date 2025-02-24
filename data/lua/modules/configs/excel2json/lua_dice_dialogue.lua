module("modules.configs.excel2json.lua_dice_dialogue", package.seeall)

slot1 = {
	speaker = 3,
	desc = 4,
	line = 5,
	type = 6,
	id = 1,
	step = 2
}
slot2 = {
	"id",
	"step"
}
slot3 = {
	speaker = 1,
	desc = 2
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
