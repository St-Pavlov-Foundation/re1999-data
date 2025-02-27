module("modules.configs.excel2json.lua_rouge_monster_rule", package.seeall)

slot1 = {
	id = 1,
	unlockType = 5,
	unlockParam = 6,
	addCollection = 3,
	rare = 2,
	desc = 4
}
slot2 = {
	"id"
}
slot3 = {
	desc = 1
}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
