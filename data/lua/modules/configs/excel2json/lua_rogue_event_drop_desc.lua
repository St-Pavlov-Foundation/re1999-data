-- chunkname: @modules/configs/excel2json/lua_rogue_event_drop_desc.lua

module("modules.configs.excel2json.lua_rogue_event_drop_desc", package.seeall)

local lua_rogue_event_drop_desc = {}
local fields = {
	icon = 5,
	iconbg = 6,
	type = 1,
	id = 2,
	title = 3,
	desc = 4
}
local primaryKey = {
	"type",
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rogue_event_drop_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_drop_desc, "configList", _configList)
	rawset(lua_rogue_event_drop_desc, "configDict", _configDict)
end

setmetatable(lua_rogue_event_drop_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_drop_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_drop_desc, "configList", nil)
	rawset(lua_rogue_event_drop_desc, "configDict", nil)
end

return lua_rogue_event_drop_desc
