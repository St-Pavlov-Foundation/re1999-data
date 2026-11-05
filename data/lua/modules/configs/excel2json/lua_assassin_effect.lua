-- chunkname: @modules/configs/excel2json/lua_assassin_effect.lua

module("modules.configs.excel2json.lua_assassin_effect", package.seeall)

local lua_assassin_effect = {}
local fields = {
	resName = 2,
	duration = 3,
	id = 1,
	audioId = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_effect, "configList", _configList)
	rawset(lua_assassin_effect, "configDict", _configDict)
end

setmetatable(lua_assassin_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_effect, "configList", nil)
	rawset(lua_assassin_effect, "configDict", nil)
end

return lua_assassin_effect
