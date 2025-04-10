module("modules.configs.excel2json.lua_activity191_reservestar", package.seeall)

slot1 = {
	id = 1,
	attribute = 2
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
