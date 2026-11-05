-- chunkname: @modules/configs/excel2json/lua_skin_effect_mainframe.lua

module("modules.configs.excel2json.lua_skin_effect_mainframe", package.seeall)

local lua_skin_effect_mainframe = {}
local fields = {
	id = 1,
	effect = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_effect_mainframe_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_effect_mainframe, "configList", _configList)
	rawset(lua_skin_effect_mainframe, "configDict", _configDict)
end

setmetatable(lua_skin_effect_mainframe, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_effect_mainframe.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_effect_mainframe, "configList", nil)
	rawset(lua_skin_effect_mainframe, "configDict", nil)
end

return lua_skin_effect_mainframe
