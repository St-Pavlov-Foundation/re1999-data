-- chunkname: @modules/configs/excel2json/lua_activity128_boss_type.lua

module("modules.configs.excel2json.lua_activity128_boss_type", package.seeall)

local lua_activity128_boss_type = {}
local fields = {
	career_weak = 3,
	recommendStrategy = 2,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity128_boss_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_boss_type, "configList", _configList)
	rawset(lua_activity128_boss_type, "configDict", _configDict)
end

setmetatable(lua_activity128_boss_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_boss_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_boss_type, "configList", nil)
	rawset(lua_activity128_boss_type, "configDict", nil)
end

return lua_activity128_boss_type
