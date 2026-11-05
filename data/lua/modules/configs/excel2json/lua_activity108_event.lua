-- chunkname: @modules/configs/excel2json/lua_activity108_event.lua

module("modules.configs.excel2json.lua_activity108_event", package.seeall)

local lua_activity108_event = {}
local fields = {
	pos = 9,
	conditionParam = 4,
	type = 5,
	group = 6,
	title = 8,
	condition = 3,
	episodeId = 2,
	interactParam = 7,
	model = 10,
	id = 1,
	modelPos = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity108_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_event, "configList", _configList)
	rawset(lua_activity108_event, "configDict", _configDict)
end

setmetatable(lua_activity108_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_event, "configList", nil)
	rawset(lua_activity108_event, "configDict", nil)
end

return lua_activity108_event
