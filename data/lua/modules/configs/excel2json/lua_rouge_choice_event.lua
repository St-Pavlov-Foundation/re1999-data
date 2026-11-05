-- chunkname: @modules/configs/excel2json/lua_rouge_choice_event.lua

module("modules.configs.excel2json.lua_rouge_choice_event", package.seeall)

local lua_rouge_choice_event = {}
local fields = {
	version = 3,
	image = 6,
	type = 2,
	id = 1,
	title = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge_choice_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_choice_event, "configList", _configList)
	rawset(lua_rouge_choice_event, "configDict", _configDict)
end

setmetatable(lua_rouge_choice_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_choice_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_choice_event, "configList", nil)
	rawset(lua_rouge_choice_event, "configDict", nil)
end

return lua_rouge_choice_event
