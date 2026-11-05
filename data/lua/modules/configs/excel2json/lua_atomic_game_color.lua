-- chunkname: @modules/configs/excel2json/lua_atomic_game_color.lua

module("modules.configs.excel2json.lua_atomic_game_color", package.seeall)

local lua_atomic_game_color = {}
local fields = {
	outerPoint = 2,
	innerPoint = 3,
	id = 1,
	title = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.atomic_game_color_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_game_color, "configList", _configList)
	rawset(lua_atomic_game_color, "configDict", _configDict)
end

setmetatable(lua_atomic_game_color, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_game_color.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_game_color, "configList", nil)
	rawset(lua_atomic_game_color, "configDict", nil)
end

return lua_atomic_game_color
