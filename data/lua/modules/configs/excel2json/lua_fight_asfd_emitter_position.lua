module("modules.configs.excel2json.lua_fight_asfd_emitter_position", package.seeall)

slot1 = {
	sceneId = 1,
	enemySidePos = 4,
	emitterId = 2,
	mySidePos = 3
}
slot2 = {
	"sceneId",
	"emitterId"
}
slot3 = {}

return {
	onLoad = function (slot0)
		uv0.configList, uv0.configDict = JsonToLuaParser.parse(slot0, uv1, uv2, uv3)
	end
}
