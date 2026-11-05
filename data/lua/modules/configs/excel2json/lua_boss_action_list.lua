-- chunkname: @modules/configs/excel2json/lua_boss_action_list.lua

module("modules.configs.excel2json.lua_boss_action_list", package.seeall)

local lua_boss_action_list = {}
local fields = {
	actionId = 1,
	actionId3 = 5,
	actionId7 = 9,
	actionId4 = 6,
	actionId10 = 12,
	actionId5 = 7,
	actionId6 = 8,
	circle = 2,
	actionId8 = 10,
	actionId1 = 3,
	actionId9 = 11,
	actionId2 = 4
}
local primaryKey = {
	"actionId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.boss_action_list_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_boss_action_list, "configList", _configList)
	rawset(lua_boss_action_list, "configDict", _configDict)
end

setmetatable(lua_boss_action_list, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_boss_action_list.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_boss_action_list, "configList", nil)
	rawset(lua_boss_action_list, "configDict", nil)
end

return lua_boss_action_list
