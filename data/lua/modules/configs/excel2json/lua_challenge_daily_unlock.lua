module("modules.configs.excel2json.lua_challenge_daily_unlock", package.seeall)

slot1 = {
	groupId = 1,
	unlock = 2
}
slot2 = {
	"groupId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
