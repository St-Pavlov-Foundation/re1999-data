-- chunkname: @modules/configs/excel2json/lua_activity244_gem_droprate.lua

module("modules.configs.excel2json.lua_activity244_gem_droprate", package.seeall)

local lua_activity244_gem_droprate = {}
local fields = {
	boxDropRate = 4,
	bombDropRate = 3,
	gemTemplateId = 1,
	healDropRate = 2
}
local primaryKey = {
	"gemTemplateId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_gem_droprate_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_gem_droprate, "configList", _configList)
	rawset(lua_activity244_gem_droprate, "configDict", _configDict)
end

setmetatable(lua_activity244_gem_droprate, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_gem_droprate.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_gem_droprate, "configList", nil)
	rawset(lua_activity244_gem_droprate, "configDict", nil)
end

return lua_activity244_gem_droprate
