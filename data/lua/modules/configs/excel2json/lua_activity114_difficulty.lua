-- chunkname: @modules/configs/excel2json/lua_activity114_difficulty.lua

module("modules.configs.excel2json.lua_activity114_difficulty", package.seeall)

local lua_activity114_difficulty = {}
local fields = {
	interval = 2,
	id = 1,
	word = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	word = 1
}
local _configList, _configDict
local configPath = "configs.activity114_difficulty_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_difficulty, "configList", _configList)
	rawset(lua_activity114_difficulty, "configDict", _configDict)
end

setmetatable(lua_activity114_difficulty, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_difficulty.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_difficulty, "configList", nil)
	rawset(lua_activity114_difficulty, "configDict", nil)
end

return lua_activity114_difficulty
