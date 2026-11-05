-- chunkname: @modules/configs/excel2json/lua_odyssey_equip_suit_effect.lua

module("modules.configs.excel2json.lua_odyssey_equip_suit_effect", package.seeall)

local lua_odyssey_equip_suit_effect = {}
local fields = {
	addRule = 5,
	effect = 6,
	number = 3,
	id = 1,
	addSkill = 4,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {
	effect = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_equip_suit_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_equip_suit_effect, "configList", _configList)
	rawset(lua_odyssey_equip_suit_effect, "configDict", _configDict)
end

setmetatable(lua_odyssey_equip_suit_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_equip_suit_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_equip_suit_effect, "configList", nil)
	rawset(lua_odyssey_equip_suit_effect, "configDict", nil)
end

return lua_odyssey_equip_suit_effect
