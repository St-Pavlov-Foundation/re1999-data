-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_grid_cell.lua

module("modules.configs.excel2json.lua_arcade_survivor_grid_cell", package.seeall)

local lua_arcade_survivor_grid_cell = {}
local fields = {
	skillIds = 9,
	name = 2,
	icon = 7,
	type = 4,
	shape = 5,
	posOffset = 11,
	showId = 10,
	desc = 3,
	resName = 6,
	id = 1,
	durationTicks = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_grid_cell_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_grid_cell, "configList", _configList)
	rawset(lua_arcade_survivor_grid_cell, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_grid_cell, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_grid_cell.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_grid_cell, "configList", nil)
	rawset(lua_arcade_survivor_grid_cell, "configDict", nil)
end

return lua_arcade_survivor_grid_cell
