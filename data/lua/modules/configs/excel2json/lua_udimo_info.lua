-- chunkname: @modules/configs/excel2json/lua_udimo_info.lua

module("modules.configs.excel2json.lua_udimo_info", package.seeall)

local lua_udimo_info = {}
local fields = {
	id = 1,
	langId = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_info_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_info, "configList", _configList)
	rawset(lua_udimo_info, "configDict", _configDict)
end

setmetatable(lua_udimo_info, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_info.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_info, "configList", nil)
	rawset(lua_udimo_info, "configDict", nil)
end

return lua_udimo_info
