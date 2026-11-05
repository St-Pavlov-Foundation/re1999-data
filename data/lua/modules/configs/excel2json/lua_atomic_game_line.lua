-- chunkname: @modules/configs/excel2json/lua_atomic_game_line.lua

module("modules.configs.excel2json.lua_atomic_game_line", package.seeall)

local lua_atomic_game_line = {}
local fields = {
	desc = 5,
	targetType = 3,
	id = 1,
	title = 4,
	shootType = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.atomic_game_line_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_game_line, "configList", _configList)
	rawset(lua_atomic_game_line, "configDict", _configDict)
end

setmetatable(lua_atomic_game_line, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_game_line.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_game_line, "configList", nil)
	rawset(lua_atomic_game_line, "configDict", nil)
end

return lua_atomic_game_line
