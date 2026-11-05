-- chunkname: @modules/configs/excel2json/lua_rouge2_layer.lua

module("modules.configs.excel2json.lua_rouge2_layer", package.seeall)

local lua_rouge2_layer = {}
local fields = {
	pathPos = 13,
	name = 2,
	desc = 10,
	pathRes = 12,
	levelId = 19,
	sceneId = 18,
	bgm = 17,
	unlock = 8,
	gridPosType1 = 20,
	crossDesc = 11,
	weather = 3,
	gridPosType2 = 21,
	startStoryId = 6,
	endStoryId = 7,
	mapRes = 5,
	middleLayerId = 4,
	iconRes = 14,
	dayOrNight = 16,
	id = 1,
	iconPos = 15,
	gridPosType3 = 22,
	nameEn = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	crossDesc = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_layer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_layer, "configList", _configList)
	rawset(lua_rouge2_layer, "configDict", _configDict)
end

setmetatable(lua_rouge2_layer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_layer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_layer, "configList", nil)
	rawset(lua_rouge2_layer, "configDict", nil)
end

return lua_rouge2_layer
