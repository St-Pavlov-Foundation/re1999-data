module("modules.configs.excel2json.lua_weekwalk_ver2_cup", package.seeall)

slot1 = {
	fightType = 3,
	layerId = 2,
	progressDesc = 10,
	desc1 = 6,
	paramOfProgressDesc = 11,
	cupNo = 4,
	desc = 9,
	desc2 = 7,
	id = 1,
	cupTask = 5,
	desc3 = 8
}
slot2 = {
	"id"
}
slot3 = {
	desc3 = 3,
	desc2 = 2,
	progressDesc = 5,
	desc1 = 1,
	desc = 4
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
