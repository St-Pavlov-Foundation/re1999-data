-- chunkname: @modules/configs/excel2json/lua_skin_ui_effect.lua

module("modules.configs.excel2json.lua_skin_ui_effect", package.seeall)

local lua_skin_ui_effect = {}
local fields = {
	delayVisible = 5,
	effect = 2,
	id = 1,
	changeVisible = 4,
	realtime = 7,
	scale = 3,
	frameVisible = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_ui_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_ui_effect, "configList", _configList)
	rawset(lua_skin_ui_effect, "configDict", _configDict)
end

setmetatable(lua_skin_ui_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_ui_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_ui_effect, "configList", nil)
	rawset(lua_skin_ui_effect, "configDict", nil)
end

return lua_skin_ui_effect
