-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_talk.lua

module("modules.configs.excel2json.lua_arcade_survivor_talk", package.seeall)

local lua_arcade_survivor_talk = {}
local fields = {
	groupId = 1,
	weight = 3,
	condition = 2
}
local primaryKey = {
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_talk, "configList", _configList)
	rawset(lua_arcade_survivor_talk, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_talk, "configList", nil)
	rawset(lua_arcade_survivor_talk, "configDict", nil)
end

return lua_arcade_survivor_talk
