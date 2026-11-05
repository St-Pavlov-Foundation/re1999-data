-- chunkname: @modules/configs/excel2json/lua_assassin_stealth_mission.lua

module("modules.configs.excel2json.lua_assassin_stealth_mission", package.seeall)

local lua_assassin_stealth_mission = {}
local fields = {
	tips = 7,
	type = 3,
	param = 4,
	refresh1 = 8,
	random = 10,
	trigger = 6,
	desc = 5,
	next_mission = 2,
	id = 1,
	refresh2 = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.assassin_stealth_mission_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_stealth_mission, "configList", _configList)
	rawset(lua_assassin_stealth_mission, "configDict", _configDict)
end

setmetatable(lua_assassin_stealth_mission, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_stealth_mission.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_stealth_mission, "configList", nil)
	rawset(lua_assassin_stealth_mission, "configDict", nil)
end

return lua_assassin_stealth_mission
