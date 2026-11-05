-- chunkname: @modules/configs/excel2json/lua_activity220_igor_base.lua

module("modules.configs.excel2json.lua_activity220_igor_base", package.seeall)

local lua_activity220_igor_base = {}
local fields = {
	cost = 4,
	costLimit = 3,
	damage = 7,
	attackRange = 6,
	skill1Times = 9,
	attackSpeed = 5,
	skill2Times = 10,
	health = 8,
	id = 1,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_igor_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_igor_base, "configList", _configList)
	rawset(lua_activity220_igor_base, "configDict", _configDict)
end

setmetatable(lua_activity220_igor_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_igor_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_igor_base, "configList", nil)
	rawset(lua_activity220_igor_base, "configDict", nil)
end

return lua_activity220_igor_base
