-- chunkname: @modules/configs/excel2json/lua_rouge2_special_event.lua

module("modules.configs.excel2json.lua_rouge2_special_event", package.seeall)

local lua_rouge2_special_event = {}
local fields = {
	id = 1,
	param = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_special_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_special_event, "configList", _configList)
	rawset(lua_rouge2_special_event, "configDict", _configDict)
end

setmetatable(lua_rouge2_special_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_special_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_special_event, "configList", nil)
	rawset(lua_rouge2_special_event, "configDict", nil)
end

return lua_rouge2_special_event
