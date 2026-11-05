-- chunkname: @modules/configs/excel2json/lua_gm_command.lua

module("modules.configs.excel2json.lua_gm_command", package.seeall)

local lua_gm_command = {}
local fields = {
	id = 1,
	name = 3,
	command = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.gm_command_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_gm_command, "configList", _configList)
	rawset(lua_gm_command, "configDict", _configDict)
end

setmetatable(lua_gm_command, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_gm_command.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_gm_command, "configList", nil)
	rawset(lua_gm_command, "configDict", nil)
end

return lua_gm_command
