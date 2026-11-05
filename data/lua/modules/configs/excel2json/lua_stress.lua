-- chunkname: @modules/configs/excel2json/lua_stress.lua

module("modules.configs.excel2json.lua_stress", package.seeall)

local lua_stress = {}
local fields = {
	desc = 3,
	pressParam = 7,
	rule = 8,
	type = 6,
	id = 1,
	title = 4,
	condition = 5,
	identity = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.stress_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_stress, "configList", _configList)
	rawset(lua_stress, "configDict", _configDict)
end

setmetatable(lua_stress, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_stress.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_stress, "configList", nil)
	rawset(lua_stress, "configDict", nil)
end

return lua_stress
