-- chunkname: @modules/configs/excel2json/lua_sodache_difficulty.lua

module("modules.configs.excel2json.lua_sodache_difficulty", package.seeall)

local lua_sodache_difficulty = {}
local fields = {
	stepAttr = 3,
	evil = 2,
	difficulty = 1
}
local primaryKey = {
	"difficulty",
	"evil"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sodache_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_difficulty, "configList", _configList)
	rawset(lua_sodache_difficulty, "configDict", _configDict)
end

setmetatable(lua_sodache_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_difficulty, "configList", nil)
	rawset(lua_sodache_difficulty, "configDict", nil)
end

return lua_sodache_difficulty
