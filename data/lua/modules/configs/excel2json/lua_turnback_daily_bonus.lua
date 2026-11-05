-- chunkname: @modules/configs/excel2json/lua_turnback_daily_bonus.lua

module("modules.configs.excel2json.lua_turnback_daily_bonus", package.seeall)

local lua_turnback_daily_bonus = {}
local fields = {
	bonus = 3,
	turnbackId = 1,
	day = 2
}
local primaryKey = {
	"turnbackId",
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_daily_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_daily_bonus, "configList", _configList)
	rawset(lua_turnback_daily_bonus, "configDict", _configDict)
end

setmetatable(lua_turnback_daily_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_daily_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_daily_bonus, "configList", nil)
	rawset(lua_turnback_daily_bonus, "configDict", nil)
end

return lua_turnback_daily_bonus
