-- chunkname: @modules/configs/excel2json/lua_talent_effectiveness.lua

module("modules.configs.excel2json.lua_talent_effectiveness", package.seeall)

local lua_talent_effectiveness = {}
local fields = {
	sr = 3,
	ssr = 2,
	r = 4,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.talent_effectiveness_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_talent_effectiveness, "configList", _configList)
	rawset(lua_talent_effectiveness, "configDict", _configDict)
end

setmetatable(lua_talent_effectiveness, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_talent_effectiveness.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_talent_effectiveness, "configList", nil)
	rawset(lua_talent_effectiveness, "configDict", nil)
end

return lua_talent_effectiveness
