-- chunkname: @modules/configs/excel2json/lua_arcade_talk.lua

module("modules.configs.excel2json.lua_arcade_talk", package.seeall)

local lua_arcade_talk = {}
local fields = {
	param = 4,
	groupId = 2,
	weight = 5,
	id = 1,
	condition = 3
}
local primaryKey = {
	"id",
	"groupId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_talk, "configList", _configList)
	rawset(lua_arcade_talk, "configDict", _configDict)
end

setmetatable(lua_arcade_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_talk, "configList", nil)
	rawset(lua_arcade_talk, "configDict", nil)
end

return lua_arcade_talk
