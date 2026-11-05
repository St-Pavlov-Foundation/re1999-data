-- chunkname: @modules/configs/excel2json/lua_rouge_layer.lua

module("modules.configs.excel2json.lua_rouge_layer", package.seeall)

local lua_rouge_layer = {}
local fields = {
	version = 2,
	name = 3,
	ruleIdVersion = 5,
	unlockType = 10,
	levelId = 22,
	pathPos = 17,
	iconPos = 18,
	desc = 13,
	bgm = 20,
	crossDesc = 14,
	sceneId = 21,
	ruleIdInstead = 6,
	startStoryId = 8,
	endStoryId = 9,
	mapRes = 7,
	middleLayerId = 4,
	unlockParam = 11,
	iconRes = 15,
	dayOrNight = 19,
	id = 1,
	pathRes = 16,
	nameEn = 12
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
local configPath = "configs.rouge_layer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_layer, "configList", _configList)
	rawset(lua_rouge_layer, "configDict", _configDict)
end

setmetatable(lua_rouge_layer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_layer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_layer, "configList", nil)
	rawset(lua_rouge_layer, "configDict", nil)
end

return lua_rouge_layer
