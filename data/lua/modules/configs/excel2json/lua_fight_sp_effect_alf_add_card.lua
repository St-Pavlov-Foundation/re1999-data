module("modules.configs.excel2json.lua_fight_sp_effect_alf_add_card", package.seeall)

slot1 = {
	effect = 2,
	skinId = 1
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
