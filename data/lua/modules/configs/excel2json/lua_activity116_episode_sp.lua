-- chunkname: @modules/configs/excel2json/lua_activity116_episode_sp.lua

module("modules.configs.excel2json.lua_activity116_episode_sp", package.seeall)

local lua_activity116_episode_sp = {}
local fields = {
	endShow = 5,
	id = 1,
	title = 3,
	refreshDay = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	endShow = 3,
	title = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity116_episode_sp_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity116_episode_sp, "configList", _configList)
	rawset(lua_activity116_episode_sp, "configDict", _configDict)
end

setmetatable(lua_activity116_episode_sp, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity116_episode_sp.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity116_episode_sp, "configList", nil)
	rawset(lua_activity116_episode_sp, "configDict", nil)
end

return lua_activity116_episode_sp
