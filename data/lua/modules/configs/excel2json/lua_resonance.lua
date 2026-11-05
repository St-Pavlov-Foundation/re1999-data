-- chunkname: @modules/configs/excel2json/lua_resonance.lua

module("modules.configs.excel2json.lua_resonance", package.seeall)

local lua_resonance = {}
local fields = {
	desc = 3,
	name = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.resonance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_resonance, "configList", _configList)
	rawset(lua_resonance, "configDict", _configDict)
end

setmetatable(lua_resonance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_resonance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_resonance, "configList", nil)
	rawset(lua_resonance, "configDict", nil)
end

return lua_resonance
