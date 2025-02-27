module("modules.configs.excel2json.lua_fight_sp_effect_alf", package.seeall)

slot1 = {
	resName = 1,
	residualRes = 2,
	pullOutRes = 3,
	audioId = 4
}
slot2 = {
	"resName"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
