-- chunkname: @modules/configs/excel2json/lua_auto_chess_function.lua

module("modules.configs.excel2json.lua_auto_chess_function", package.seeall)

local lua_auto_chess_function = {}
local fields = {
	id = 1,
	functionOn = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_function_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_function, "configList", _configList)
	rawset(lua_auto_chess_function, "configDict", _configDict)
end

setmetatable(lua_auto_chess_function, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_function.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_function, "configList", nil)
	rawset(lua_auto_chess_function, "configDict", nil)
end

return lua_auto_chess_function
