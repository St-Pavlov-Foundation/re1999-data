-- chunkname: @modules/configs/excel2json/lua_fight_ui_effect.lua

module("modules.configs.excel2json.lua_fight_ui_effect", package.seeall)

local lua_fight_ui_effect = {}
local fields = {
	id = 1,
	name = 2,
	res = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.fight_ui_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_ui_effect, "configList", _configList)
	rawset(lua_fight_ui_effect, "configDict", _configDict)
end

setmetatable(lua_fight_ui_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_ui_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_ui_effect, "configList", nil)
	rawset(lua_fight_ui_effect, "configDict", nil)
end

return lua_fight_ui_effect
