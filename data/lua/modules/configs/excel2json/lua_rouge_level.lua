-- chunkname: @modules/configs/excel2json/lua_rouge_level.lua

module("modules.configs.excel2json.lua_rouge_level", package.seeall)

local lua_rouge_level = {}
local fields = {
	season = 1,
	exp = 3,
	level = 2
}
local primaryKey = {
	"season",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_level, "configList", _configList)
	rawset(lua_rouge_level, "configDict", _configDict)
end

setmetatable(lua_rouge_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_level, "configList", nil)
	rawset(lua_rouge_level, "configDict", nil)
end

return lua_rouge_level
