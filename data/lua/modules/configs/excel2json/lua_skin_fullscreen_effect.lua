-- chunkname: @modules/configs/excel2json/lua_skin_fullscreen_effect.lua

module("modules.configs.excel2json.lua_skin_fullscreen_effect", package.seeall)

local lua_skin_fullscreen_effect = {}
local fields = {
	id = 1,
	effectList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_fullscreen_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_fullscreen_effect, "configList", _configList)
	rawset(lua_skin_fullscreen_effect, "configDict", _configDict)
end

setmetatable(lua_skin_fullscreen_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_fullscreen_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_fullscreen_effect, "configList", nil)
	rawset(lua_skin_fullscreen_effect, "configDict", nil)
end

return lua_skin_fullscreen_effect
