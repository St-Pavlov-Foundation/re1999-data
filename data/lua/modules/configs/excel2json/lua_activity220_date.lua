-- chunkname: @modules/configs/excel2json/lua_activity220_date.lua

module("modules.configs.excel2json.lua_activity220_date", package.seeall)

local lua_activity220_date = {}
local fields = {
	eventType = 3,
	day = 2,
	difficult = 5,
	eventParam = 4,
	gameId = 1
}
local primaryKey = {
	"gameId",
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_date_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_date, "configList", _configList)
	rawset(lua_activity220_date, "configDict", _configDict)
end

setmetatable(lua_activity220_date, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_date.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_date, "configList", nil)
	rawset(lua_activity220_date, "configDict", nil)
end

return lua_activity220_date
