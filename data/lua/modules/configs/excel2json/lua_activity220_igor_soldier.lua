-- chunkname: @modules/configs/excel2json/lua_activity220_igor_soldier.lua

module("modules.configs.excel2json.lua_activity220_igor_soldier", package.seeall)

local lua_activity220_igor_soldier = {}
local fields = {
	cost = 3,
	isHero = 12,
	damage = 7,
	type = 2,
	counter = 9,
	attackSpeed = 5,
	attackRange = 6,
	unlock = 11,
	speed = 4,
	name = 13,
	desc = 14,
	health = 8,
	id = 1,
	usecd = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity220_igor_soldier_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_igor_soldier, "configList", _configList)
	rawset(lua_activity220_igor_soldier, "configDict", _configDict)
end

setmetatable(lua_activity220_igor_soldier, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_igor_soldier.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_igor_soldier, "configList", nil)
	rawset(lua_activity220_igor_soldier, "configDict", nil)
end

return lua_activity220_igor_soldier
