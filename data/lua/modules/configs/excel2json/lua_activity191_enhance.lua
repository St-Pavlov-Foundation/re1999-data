module("modules.configs.excel2json.lua_activity191_enhance", package.seeall)

slot1 = {
	effects = 8,
	name = 3,
	relateItem = 6,
	relateHero = 5,
	id = 1,
	icon = 7,
	activityId = 2,
	desc = 4
}
slot2 = {
	"id",
	"activityId"
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
