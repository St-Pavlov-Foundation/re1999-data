module("modules.configs.excel2json.lua_fight_buff_type_id_2_scene_effect", package.seeall)

slot1 = {
	id = 1,
	effect = 2,
	pos = 3,
	reverseX = 4
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
