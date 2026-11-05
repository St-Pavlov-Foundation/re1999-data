-- chunkname: @modules/configs/excel2json/lua_rouge_event_type.lua

module("modules.configs.excel2json.lua_rouge_event_type", package.seeall)

local lua_rouge_event_type = {}
local fields = {
	name = 3,
	version = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_event_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_event_type, "configList", _configList)
	rawset(lua_rouge_event_type, "configDict", _configDict)
end

setmetatable(lua_rouge_event_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_event_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_event_type, "configList", nil)
	rawset(lua_rouge_event_type, "configDict", nil)
end

return lua_rouge_event_type
