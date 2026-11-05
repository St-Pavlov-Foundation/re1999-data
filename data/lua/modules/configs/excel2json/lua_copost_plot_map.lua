-- chunkname: @modules/configs/excel2json/lua_copost_plot_map.lua

module("modules.configs.excel2json.lua_copost_plot_map", package.seeall)

local lua_copost_plot_map = {}
local fields = {
	id = 1,
	mapName = 5,
	time = 2,
	centerPoint = 3,
	scale = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	mapName = 1
}
local _configList, _configDict
local configPath = "configs.copost_plot_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_plot_map, "configList", _configList)
	rawset(lua_copost_plot_map, "configDict", _configDict)
end

setmetatable(lua_copost_plot_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_plot_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_plot_map, "configList", nil)
	rawset(lua_copost_plot_map, "configDict", nil)
end

return lua_copost_plot_map
