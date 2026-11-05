-- chunkname: @modules/configs/excel2json/lua_assassin_style_constant.lua

module("modules.configs.excel2json.lua_assassin_style_constant", package.seeall)

local lua_assassin_style_constant = {}
local fields = {
	id = 1,
	constant = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_style_constant_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_style_constant, "configList", _configList)
	rawset(lua_assassin_style_constant, "configDict", _configDict)
end

setmetatable(lua_assassin_style_constant, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_style_constant.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_style_constant, "configList", nil)
	rawset(lua_assassin_style_constant, "configDict", nil)
end

return lua_assassin_style_constant
