-- chunkname: @modules/configs/excel2json/lua_viewhelp.lua

module("modules.configs.excel2json.lua_viewhelp", package.seeall)

local lua_viewhelp = {}
local fields = {
	id = 1,
	page = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.viewhelp_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_viewhelp, "configList", _configList)
	rawset(lua_viewhelp, "configDict", _configDict)
end

setmetatable(lua_viewhelp, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_viewhelp.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_viewhelp, "configList", nil)
	rawset(lua_viewhelp, "configDict", nil)
end

return lua_viewhelp
