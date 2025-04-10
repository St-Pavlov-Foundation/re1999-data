module("modules.configs.excel2json.lua_tower_talent_plan", package.seeall)

slot1 = {
	bossId = 1,
	talentIds = 3,
	planId = 2,
	planName = 4
}
slot2 = {
	"bossId",
	"planId"
}
slot3 = {
	planName = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
