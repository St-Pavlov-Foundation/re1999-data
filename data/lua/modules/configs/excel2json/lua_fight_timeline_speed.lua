-- chunkname: @modules/configs/excel2json/lua_fight_timeline_speed.lua

module("modules.configs.excel2json.lua_fight_timeline_speed", package.seeall)

local lua_fight_timeline_speed = {}
local fields = {
	speed = 2,
	timeline = 1
}
local primaryKey = {
	"timeline"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_timeline_speed_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_timeline_speed, "configList", _configList)
	rawset(lua_fight_timeline_speed, "configDict", _configDict)
end

setmetatable(lua_fight_timeline_speed, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_timeline_speed.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_timeline_speed, "configList", nil)
	rawset(lua_fight_timeline_speed, "configDict", nil)
end

return lua_fight_timeline_speed
