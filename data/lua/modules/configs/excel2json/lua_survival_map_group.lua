-- chunkname: @modules/configs/excel2json/lua_survival_map_group.lua

module("modules.configs.excel2json.lua_survival_map_group", package.seeall)

local lua_survival_map_group = {}
local fields = {
	effectDesc = 6,
	name = 3,
	useScene = 5,
	type = 2,
	disasterLayout = 9,
	initDisaster = 8,
	mapRichness = 10,
	desc = 4,
	id = 1,
	hardLevel = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.survival_map_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_map_group, "configList", _configList)
	rawset(lua_survival_map_group, "configDict", _configDict)
end

setmetatable(lua_survival_map_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_map_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_map_group, "configList", nil)
	rawset(lua_survival_map_group, "configDict", nil)
end

return lua_survival_map_group
