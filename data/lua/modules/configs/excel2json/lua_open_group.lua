-- chunkname: @modules/configs/excel2json/lua_open_group.lua

module("modules.configs.excel2json.lua_open_group", package.seeall)

local lua_open_group = {}
local fields = {
	need_finish_guide = 6,
	hero_number = 2,
	need_episode = 4,
	need_enter_episode = 5,
	id = 1,
	showInEpisode = 7,
	need_level = 3,
	lock_desc = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.open_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_open_group, "configList", _configList)
	rawset(lua_open_group, "configDict", _configDict)
end

setmetatable(lua_open_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_open_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_open_group, "configList", nil)
	rawset(lua_open_group, "configDict", nil)
end

return lua_open_group
