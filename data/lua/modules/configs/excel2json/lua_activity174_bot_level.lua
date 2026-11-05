-- chunkname: @modules/configs/excel2json/lua_activity174_bot_level.lua

module("modules.configs.excel2json.lua_activity174_bot_level", package.seeall)

local lua_activity174_bot_level = {}
local fields = {
	upWin = 3,
	downLost = 4,
	rank = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity174_bot_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity174_bot_level, "configList", _configList)
	rawset(lua_activity174_bot_level, "configDict", _configDict)
end

setmetatable(lua_activity174_bot_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity174_bot_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity174_bot_level, "configList", nil)
	rawset(lua_activity174_bot_level, "configDict", nil)
end

return lua_activity174_bot_level
