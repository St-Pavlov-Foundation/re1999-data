-- chunkname: @modules/configs/excel2json/lua_critter_patience_change.lua

module("modules.configs.excel2json.lua_critter_patience_change", package.seeall)

local lua_critter_patience_change = {}
local fields = {
	stepValue = 3,
	stepTime = 2,
	buildingType = 1
}
local primaryKey = {
	"buildingType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_patience_change_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_patience_change, "configList", _configList)
	rawset(lua_critter_patience_change, "configDict", _configDict)
end

setmetatable(lua_critter_patience_change, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_patience_change.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_patience_change, "configList", nil)
	rawset(lua_critter_patience_change, "configDict", nil)
end

return lua_critter_patience_change
