module("modules.configs.excel2json.lua_activity191_pvp_match", package.seeall)

slot1 = {
	rewardView = 2,
	attribute = 4,
	autoRewardView = 3,
	type = 1
}
slot2 = {
	"type"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
