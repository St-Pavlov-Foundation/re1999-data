-- chunkname: @modules/configs/excel2json/lua_assassin_home.lua

module("modules.configs.excel2json.lua_assassin_home", package.seeall)

local lua_assassin_home = {}
local fields = {
	unlock = 5,
	effect = 7,
	unlockDesc = 6,
	type = 3,
	id = 1,
	title = 2,
	effectDesc = 8,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	effectDesc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.assassin_home_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_home, "configList", _configList)
	rawset(lua_assassin_home, "configDict", _configDict)
end

setmetatable(lua_assassin_home, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_home.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_home, "configList", nil)
	rawset(lua_assassin_home, "configDict", nil)
end

return lua_assassin_home
