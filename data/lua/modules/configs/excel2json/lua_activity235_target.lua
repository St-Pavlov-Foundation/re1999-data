-- chunkname: @modules/configs/excel2json/lua_activity235_target.lua

module("modules.configs.excel2json.lua_activity235_target", package.seeall)

local lua_activity235_target = {}
local fields = {
	hitDisappearDelay = 10,
	disappearTime = 8,
	hitRadius = 13,
	prefab = 3,
	name = 2,
	maxShowNum = 11,
	id = 1,
	disappearDealy = 9,
	firstShowNum = 12,
	afterScore = 6,
	appearTime = 7,
	firstScore = 5,
	weight = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity235_target_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity235_target, "configList", _configList)
	rawset(lua_activity235_target, "configDict", _configDict)
end

setmetatable(lua_activity235_target, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity235_target.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity235_target, "configList", nil)
	rawset(lua_activity235_target, "configDict", nil)
end

return lua_activity235_target
