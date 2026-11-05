-- chunkname: @modules/configs/excel2json/lua_rouge2_event_type.lua

module("modules.configs.excel2json.lua_rouge2_event_type", package.seeall)

local lua_rouge2_event_type = {}
local fields = {
	eventIcon = 3,
	name = 2,
	desc = 4,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	eventIcon = 2,
	name = 1,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.rouge2_event_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_event_type, "configList", _configList)
	rawset(lua_rouge2_event_type, "configDict", _configDict)
end

setmetatable(lua_rouge2_event_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_event_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_event_type, "configList", nil)
	rawset(lua_rouge2_event_type, "configDict", nil)
end

return lua_rouge2_event_type
