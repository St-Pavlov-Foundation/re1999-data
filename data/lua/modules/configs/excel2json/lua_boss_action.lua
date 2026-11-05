-- chunkname: @modules/configs/excel2json/lua_boss_action.lua

module("modules.configs.excel2json.lua_boss_action", package.seeall)

local lua_boss_action = {}
local fields = {
	battleId = 1,
	monsterId = 2,
	monsterSpeed = 3,
	actionId = 4
}
local primaryKey = {
	"battleId",
	"monsterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.boss_action_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_boss_action, "configList", _configList)
	rawset(lua_boss_action, "configDict", _configDict)
end

setmetatable(lua_boss_action, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_boss_action.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_boss_action, "configList", nil)
	rawset(lua_boss_action, "configDict", nil)
end

return lua_boss_action
