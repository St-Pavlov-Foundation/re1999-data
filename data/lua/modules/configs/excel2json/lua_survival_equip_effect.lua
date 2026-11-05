-- chunkname: @modules/configs/excel2json/lua_survival_equip_effect.lua

module("modules.configs.excel2json.lua_survival_equip_effect", package.seeall)

local lua_survival_equip_effect = {}
local fields = {
	id = 1,
	effect = 2,
	effect_score = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_equip_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_equip_effect, "configList", _configList)
	rawset(lua_survival_equip_effect, "configDict", _configDict)
end

setmetatable(lua_survival_equip_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_equip_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_equip_effect, "configList", nil)
	rawset(lua_survival_equip_effect, "configDict", nil)
end

return lua_survival_equip_effect
