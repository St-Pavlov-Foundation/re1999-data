-- chunkname: @modules/configs/excel2json/lua_exclude_config.lua

module("modules.configs.excel2json.lua_exclude_config", package.seeall)

local lua_exclude_config = {}
local fields = {
	row_sel = 4,
	json_file = 3,
	mode = 5,
	params = 6,
	id = 1,
	version = 2,
	onornot = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.exclude_config_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_exclude_config, "configList", _configList)
	rawset(lua_exclude_config, "configDict", _configDict)
end

setmetatable(lua_exclude_config, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_exclude_config.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_exclude_config, "configList", nil)
	rawset(lua_exclude_config, "configDict", nil)
end

return lua_exclude_config
