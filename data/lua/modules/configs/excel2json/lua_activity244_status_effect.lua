-- chunkname: @modules/configs/excel2json/lua_activity244_status_effect.lua

module("modules.configs.excel2json.lua_activity244_status_effect", package.seeall)

local lua_activity244_status_effect = {}
local fields = {
	durationType = 4,
	statusId = 1,
	targetType = 3,
	defaultDuration = 5,
	stackRule = 6,
	statusKey = 2,
	removeRule = 7,
	desc = 8
}
local primaryKey = {
	"statusId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity244_status_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_status_effect, "configList", _configList)
	rawset(lua_activity244_status_effect, "configDict", _configDict)
end

setmetatable(lua_activity244_status_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_status_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_status_effect, "configList", nil)
	rawset(lua_activity244_status_effect, "configDict", nil)
end

return lua_activity244_status_effect
