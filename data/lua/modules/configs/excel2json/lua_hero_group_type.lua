module("modules.configs.excel2json.lua_hero_group_type", package.seeall)

slot1 = {
	id = 1,
	name = 2,
	chapterIds = 3,
	saveGroup = 4
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
