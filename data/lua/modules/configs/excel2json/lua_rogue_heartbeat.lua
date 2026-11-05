-- chunkname: @modules/configs/excel2json/lua_rogue_heartbeat.lua

module("modules.configs.excel2json.lua_rogue_heartbeat", package.seeall)

local lua_rogue_heartbeat = {}
local fields = {
	desc = 5,
	range = 2,
	id = 1,
	title = 4,
	rule = 6,
	attr = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rogue_heartbeat_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_heartbeat, "configList", _configList)
	rawset(lua_rogue_heartbeat, "configDict", _configDict)
end

setmetatable(lua_rogue_heartbeat, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_heartbeat.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_heartbeat, "configList", nil)
	rawset(lua_rogue_heartbeat, "configDict", nil)
end

return lua_rogue_heartbeat
