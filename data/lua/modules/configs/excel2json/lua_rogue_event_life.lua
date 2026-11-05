-- chunkname: @modules/configs/excel2json/lua_rogue_event_life.lua

module("modules.configs.excel2json.lua_rogue_event_life", package.seeall)

local lua_rogue_event_life = {}
local fields = {
	id = 1,
	num = 2,
	lifeAdd = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_event_life_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_life, "configList", _configList)
	rawset(lua_rogue_event_life, "configDict", _configDict)
end

setmetatable(lua_rogue_event_life, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_life.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_life, "configList", nil)
	rawset(lua_rogue_event_life, "configDict", nil)
end

return lua_rogue_event_life
