-- chunkname: @modules/configs/excel2json/lua_activity117_talk.lua

module("modules.configs.excel2json.lua_activity117_talk", package.seeall)

local lua_activity117_talk = {}
local fields = {
	content2 = 4,
	content1 = 3,
	activityId = 1,
	type = 2
}
local primaryKey = {
	"activityId",
	"type"
}
local mlStringKey = {
	content2 = 2,
	content1 = 1
}
local _configList, _configDict
local configPath = "configs.activity117_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity117_talk, "configList", _configList)
	rawset(lua_activity117_talk, "configDict", _configDict)
end

setmetatable(lua_activity117_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity117_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity117_talk, "configList", nil)
	rawset(lua_activity117_talk, "configDict", nil)
end

return lua_activity117_talk
