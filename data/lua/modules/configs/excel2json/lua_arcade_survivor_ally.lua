-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_ally.lua

module("modules.configs.excel2json.lua_arcade_survivor_ally", package.seeall)

local lua_arcade_survivor_ally = {}
local fields = {
	resName = 3,
	name = 2,
	durationTicks = 5,
	atk = 7,
	id = 1,
	icon = 4,
	shape = 6,
	skillIds = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_ally_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_ally, "configList", _configList)
	rawset(lua_arcade_survivor_ally, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_ally, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_ally.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_ally, "configList", nil)
	rawset(lua_arcade_survivor_ally, "configDict", nil)
end

return lua_arcade_survivor_ally
