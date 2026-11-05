-- chunkname: @modules/configs/excel2json/lua_activity178_talk.lua

module("modules.configs.excel2json.lua_activity178_talk", package.seeall)

local lua_activity178_talk = {}
local fields = {
	id = 2,
	pram = 4,
	activityId = 1,
	type = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity178_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity178_talk, "configList", _configList)
	rawset(lua_activity178_talk, "configDict", _configDict)
end

setmetatable(lua_activity178_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity178_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity178_talk, "configList", nil)
	rawset(lua_activity178_talk, "configDict", nil)
end

return lua_activity178_talk
