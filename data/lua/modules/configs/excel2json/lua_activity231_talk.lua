-- chunkname: @modules/configs/excel2json/lua_activity231_talk.lua

module("modules.configs.excel2json.lua_activity231_talk", package.seeall)

local lua_activity231_talk = {}
local fields = {
	weight = 4,
	trigger = 5,
	id = 1,
	content = 3,
	researcherId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity231_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_talk, "configList", _configList)
	rawset(lua_activity231_talk, "configDict", _configDict)
end

setmetatable(lua_activity231_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_talk, "configList", nil)
	rawset(lua_activity231_talk, "configDict", nil)
end

return lua_activity231_talk
