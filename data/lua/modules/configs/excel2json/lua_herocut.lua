-- chunkname: @modules/configs/excel2json/lua_herocut.lua

module("modules.configs.excel2json.lua_herocut", package.seeall)

local lua_herocut = {}
local fields = {
	id = 1,
	cutName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.herocut_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_herocut, "configList", _configList)
	rawset(lua_herocut, "configDict", _configDict)
end

setmetatable(lua_herocut, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_herocut.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_herocut, "configList", nil)
	rawset(lua_herocut, "configDict", nil)
end

return lua_herocut
