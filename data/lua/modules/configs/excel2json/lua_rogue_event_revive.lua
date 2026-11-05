-- chunkname: @modules/configs/excel2json/lua_rogue_event_revive.lua

module("modules.configs.excel2json.lua_rogue_event_revive", package.seeall)

local lua_rogue_event_revive = {}
local fields = {
	id = 1,
	num = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_event_revive_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_revive, "configList", _configList)
	rawset(lua_rogue_event_revive, "configDict", _configDict)
end

setmetatable(lua_rogue_event_revive, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_revive.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_revive, "configList", nil)
	rawset(lua_rogue_event_revive, "configDict", nil)
end

return lua_rogue_event_revive
