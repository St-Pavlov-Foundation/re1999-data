-- chunkname: @modules/configs/excel2json/lua_activity189_style.lua

module("modules.configs.excel2json.lua_activity189_style", package.seeall)

local lua_activity189_style = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity189_style_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity189_style, "configList", _configList)
	rawset(lua_activity189_style, "configDict", _configDict)
end

setmetatable(lua_activity189_style, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity189_style.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity189_style, "configList", nil)
	rawset(lua_activity189_style, "configDict", nil)
end

return lua_activity189_style
