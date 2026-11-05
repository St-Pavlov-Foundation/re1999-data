-- chunkname: @modules/configs/excel2json/lua_activity164_bubble.lua

module("modules.configs.excel2json.lua_activity164_bubble", package.seeall)

local lua_activity164_bubble = {}
local fields = {
	id = 2,
	content = 4,
	activityId = 1,
	step = 3
}
local primaryKey = {
	"activityId",
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity164_bubble_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity164_bubble, "configList", _configList)
	rawset(lua_activity164_bubble, "configDict", _configDict)
end

setmetatable(lua_activity164_bubble, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity164_bubble.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity164_bubble, "configList", nil)
	rawset(lua_activity164_bubble, "configDict", nil)
end

return lua_activity164_bubble
