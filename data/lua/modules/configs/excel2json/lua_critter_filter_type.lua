-- chunkname: @modules/configs/excel2json/lua_critter_filter_type.lua

module("modules.configs.excel2json.lua_critter_filter_type", package.seeall)

local lua_critter_filter_type = {}
local fields = {
	tabIcon = 6,
	name = 2,
	tabName = 5,
	id = 1,
	filterTab = 4,
	nameEn = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tabName = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.critter_filter_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_filter_type, "configList", _configList)
	rawset(lua_critter_filter_type, "configDict", _configDict)
end

setmetatable(lua_critter_filter_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_filter_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_filter_type, "configList", nil)
	rawset(lua_critter_filter_type, "configDict", nil)
end

return lua_critter_filter_type
