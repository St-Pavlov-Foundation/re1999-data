module("modules.configs.excel2json.lua_fight_asfd_fly_path", package.seeall)

slot1 = {
	flyDuration = 2,
	id = 1,
	lineType = 3
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
