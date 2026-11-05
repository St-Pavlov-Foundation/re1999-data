-- chunkname: @modules/configs/excel2json/lua_college_event.lua

module("modules.configs.excel2json.lua_college_event", package.seeall)

local lua_college_event = {}
local fields = {
	title = 2,
	optionIds = 5,
	body = 3,
	id = 1,
	artAsset = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	body = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.college_event_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_event, "configList", _configList)
	rawset(lua_college_event, "configDict", _configDict)
end

setmetatable(lua_college_event, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_event.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_event, "configList", nil)
	rawset(lua_college_event, "configDict", nil)
end

return lua_college_event
