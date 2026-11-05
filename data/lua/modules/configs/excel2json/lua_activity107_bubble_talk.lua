-- chunkname: @modules/configs/excel2json/lua_activity107_bubble_talk.lua

module("modules.configs.excel2json.lua_activity107_bubble_talk", package.seeall)

local lua_activity107_bubble_talk = {}
local fields = {
	groupId = 2,
	id = 1,
	condition = 3,
	weight = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity107_bubble_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity107_bubble_talk, "configList", _configList)
	rawset(lua_activity107_bubble_talk, "configDict", _configDict)
end

setmetatable(lua_activity107_bubble_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity107_bubble_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity107_bubble_talk, "configList", nil)
	rawset(lua_activity107_bubble_talk, "configDict", nil)
end

return lua_activity107_bubble_talk
