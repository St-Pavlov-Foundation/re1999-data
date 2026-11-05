-- chunkname: @modules/configs/excel2json/lua_fight_effect.lua

module("modules.configs.excel2json.lua_fight_effect", package.seeall)

local lua_fight_effect = {}
local fields = {
	career3 = 4,
	career2 = 3,
	career1 = 2,
	career8 = 9,
	career7 = 8,
	career6 = 7,
	id = 1,
	career5 = 6,
	career4 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_effect, "configList", _configList)
	rawset(lua_fight_effect, "configDict", _configDict)
end

setmetatable(lua_fight_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_effect, "configList", nil)
	rawset(lua_fight_effect, "configDict", nil)
end

return lua_fight_effect
