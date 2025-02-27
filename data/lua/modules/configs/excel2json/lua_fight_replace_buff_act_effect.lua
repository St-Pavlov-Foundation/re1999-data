module("modules.configs.excel2json.lua_fight_replace_buff_act_effect", package.seeall)

slot1 = {
	audioId = 5,
	effect = 3,
	id = 1,
	buffActId = 2,
	effectHangPoint = 4
}
slot2 = {
	"id",
	"buffActId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
