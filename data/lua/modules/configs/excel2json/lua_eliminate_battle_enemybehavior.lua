-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_enemybehavior.lua

module("modules.configs.excel2json.lua_eliminate_battle_enemybehavior", package.seeall)

local lua_eliminate_battle_enemybehavior = {}
local fields = {
	prob3 = 9,
	list3 = 8,
	prob2 = 7,
	prob1 = 5,
	list1 = 4,
	round = 3,
	behavior = 2,
	list2 = 6,
	id = 1
}
local primaryKey = {
	"id",
	"behavior"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.eliminate_battle_enemybehavior_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_enemybehavior, "configList", _configList)
	rawset(lua_eliminate_battle_enemybehavior, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_enemybehavior, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_enemybehavior.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_enemybehavior, "configList", nil)
	rawset(lua_eliminate_battle_enemybehavior, "configDict", nil)
end

return lua_eliminate_battle_enemybehavior
