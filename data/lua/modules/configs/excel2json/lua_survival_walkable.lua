-- chunkname: @modules/configs/excel2json/lua_survival_walkable.lua

module("modules.configs.excel2json.lua_survival_walkable", package.seeall)

local lua_survival_walkable = {}
local fields = {
	id = 2,
	map = 1,
	weight = 4,
	resource = 3
}
local primaryKey = {
	"map",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_walkable_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_walkable, "configList", _configList)
	rawset(lua_survival_walkable, "configDict", _configDict)
end

setmetatable(lua_survival_walkable, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_walkable.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_walkable, "configList", nil)
	rawset(lua_survival_walkable, "configDict", nil)
end

return lua_survival_walkable
