module("modules.configs.excel2json.lua_rouge_map_choice", package.seeall)

slot1 = {
	groupId = 2,
	layerId = 1,
	dropId = 3
}
slot2 = {
	"layerId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
