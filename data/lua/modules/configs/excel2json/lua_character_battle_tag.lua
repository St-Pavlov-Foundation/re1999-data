module("modules.configs.excel2json.lua_character_battle_tag", package.seeall)

slot1 = {
	id = 1,
	tagName = 2
}
slot2 = {
	"id"
}
slot3 = {
	tagName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
