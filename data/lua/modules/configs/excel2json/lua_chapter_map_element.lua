-- chunkname: @modules/configs/excel2json/lua_chapter_map_element.lua

module("modules.configs.excel2json.lua_chapter_map_element", package.seeall)

local lua_chapter_map_element = {}
local fields = {
	mapId = 2,
	flagText = 18,
	desc = 17,
	type = 12,
	res = 5,
	title = 16,
	pos = 3,
	resScale = 6,
	acceptText = 19,
	finishText = 20,
	dispatchingText = 21,
	showCamera = 10,
	showArrow = 11,
	reward = 22,
	rewardPoint = 23,
	permanentReward = 24,
	param = 13,
	effect = 8,
	fragment = 26,
	holeSize = 25,
	retroReward = 27,
	condition = 9,
	tipOffsetPos = 7,
	paramCn = 14,
	offsetPos = 4,
	id = 1,
	paramLang = 15
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 4,
	paramCn = 1,
	flagText = 5,
	acceptText = 6,
	finishText = 7,
	title = 3,
	dispatchingText = 8,
	paramLang = 2
}
local _configList, _configDict
local configPath = "configs.chapter_map_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_map_element, "configList", _configList)
	rawset(lua_chapter_map_element, "configDict", _configDict)
end

setmetatable(lua_chapter_map_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_map_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_map_element, "configList", nil)
	rawset(lua_chapter_map_element, "configDict", nil)
end

return lua_chapter_map_element
