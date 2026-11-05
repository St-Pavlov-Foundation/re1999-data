-- chunkname: @modules/configs/excel2json/lua_assassin_interactive.lua

module("modules.configs.excel2json.lua_assassin_interactive", package.seeall)

local lua_assassin_interactive = {}
local fields = {
	gridId = 4,
	name = 2,
	missionId = 3,
	id = 1,
	costPoint = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_interactive_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_interactive, "configList", _configList)
	rawset(lua_assassin_interactive, "configDict", _configDict)
end

setmetatable(lua_assassin_interactive, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_interactive.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_interactive, "configList", nil)
	rawset(lua_assassin_interactive, "configDict", nil)
end

return lua_assassin_interactive
