-- chunkname: @modules/configs/excel2json/lua_strong_hold.lua

module("modules.configs.excel2json.lua_strong_hold", package.seeall)

local lua_strong_hold = {}
local fields = {
	ruleId = 7,
	name = 2,
	eliminateBg = 3,
	id = 1,
	strongholdBg = 4,
	friendCapacity = 6,
	enemyCapacity = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.strong_hold_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_strong_hold, "configList", _configList)
	rawset(lua_strong_hold, "configDict", _configDict)
end

setmetatable(lua_strong_hold, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_strong_hold.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_strong_hold, "configList", nil)
	rawset(lua_strong_hold, "configDict", nil)
end

return lua_strong_hold
