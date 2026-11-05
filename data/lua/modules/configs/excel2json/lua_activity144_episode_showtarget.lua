-- chunkname: @modules/configs/excel2json/lua_activity144_episode_showtarget.lua

module("modules.configs.excel2json.lua_activity144_episode_showtarget", package.seeall)

local lua_activity144_episode_showtarget = {}
local fields = {
	id = 1,
	name = 2,
	colorStr = 4,
	elevation = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity144_episode_showtarget_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_episode_showtarget, "configList", _configList)
	rawset(lua_activity144_episode_showtarget, "configDict", _configDict)
end

setmetatable(lua_activity144_episode_showtarget, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_episode_showtarget.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_episode_showtarget, "configList", nil)
	rawset(lua_activity144_episode_showtarget, "configDict", nil)
end

return lua_activity144_episode_showtarget
