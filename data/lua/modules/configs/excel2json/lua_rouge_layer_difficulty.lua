-- chunkname: @modules/configs/excel2json/lua_rouge_layer_difficulty.lua

module("modules.configs.excel2json.lua_rouge_layer_difficulty", package.seeall)

local lua_rouge_layer_difficulty = {}
local fields = {
	stepAttr = 3,
	difficulty = 1,
	layer = 2
}
local primaryKey = {
	"difficulty",
	"layer"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_layer_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_layer_difficulty, "configList", _configList)
	rawset(lua_rouge_layer_difficulty, "configDict", _configDict)
end

setmetatable(lua_rouge_layer_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_layer_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_layer_difficulty, "configList", nil)
	rawset(lua_rouge_layer_difficulty, "configDict", nil)
end

return lua_rouge_layer_difficulty
