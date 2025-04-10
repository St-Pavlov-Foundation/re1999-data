module("modules.configs.excel2json.lua_activity191_init_build", package.seeall)

slot1 = {
	name = 3,
	style = 2,
	item = 7,
	coin = 5,
	hero = 6,
	activityId = 1,
	desc = 4
}
slot2 = {
	"activityId",
	"style"
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
