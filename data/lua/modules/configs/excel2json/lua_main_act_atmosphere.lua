module("modules.configs.excel2json.lua_main_act_atmosphere", package.seeall)

slot1 = {
	id = 1,
	mainView = 3,
	isShowActBg = 7,
	isShowLogo = 6,
	mainViewActBtn = 4,
	mainThumbnailViewActBg = 10,
	effectDuration = 2,
	mainViewActBtnPrefix = 5,
	mainThumbnailView = 8,
	isShowfx = 9
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
