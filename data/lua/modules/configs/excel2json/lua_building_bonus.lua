-- chunkname: @modules/configs/excel2json/lua_building_bonus.lua

module("modules.configs.excel2json.lua_building_bonus", package.seeall)

local lua_building_bonus = {}
local fields = {
	bonus = 2,
	characterLimitAdd = 3,
	buildDegree = 1
}
local primaryKey = {
	"buildDegree"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.building_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_building_bonus, "configList", _configList)
	rawset(lua_building_bonus, "configDict", _configDict)
end

setmetatable(lua_building_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_building_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_building_bonus, "configList", nil)
	rawset(lua_building_bonus, "configDict", nil)
end

return lua_building_bonus
