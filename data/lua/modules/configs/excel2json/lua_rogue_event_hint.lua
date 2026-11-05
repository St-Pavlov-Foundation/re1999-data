-- chunkname: @modules/configs/excel2json/lua_rogue_event_hint.lua

module("modules.configs.excel2json.lua_rogue_event_hint", package.seeall)

local lua_rogue_event_hint = {}
local fields = {
	id = 1,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rogue_event_hint_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_hint, "configList", _configList)
	rawset(lua_rogue_event_hint, "configDict", _configDict)
end

setmetatable(lua_rogue_event_hint, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_hint.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_hint, "configList", nil)
	rawset(lua_rogue_event_hint, "configDict", nil)
end

return lua_rogue_event_hint
