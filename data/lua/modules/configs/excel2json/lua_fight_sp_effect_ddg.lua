module("modules.configs.excel2json.lua_fight_sp_effect_ddg", package.seeall)

slot1 = {
	addExPointEffect = 2,
	addExPointHang = 3,
	posionHang = 5,
	skinId = 1,
	posionEffect = 4
}
slot2 = {
	"skinId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
