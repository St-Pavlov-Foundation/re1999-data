-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_wuerlixi_float.lua

module("modules.configs.excel2json.lua_fight_sp_effect_wuerlixi_float", package.seeall)

local lua_fight_sp_effect_wuerlixi_float = {}
local fields = {
	audioId = 5,
	effect = 2,
	hangPoint = 3,
	skinId = 1,
	duration = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_wuerlixi_float_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_wuerlixi_float, "configList", _configList)
	rawset(lua_fight_sp_effect_wuerlixi_float, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_wuerlixi_float, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_wuerlixi_float.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_wuerlixi_float, "configList", nil)
	rawset(lua_fight_sp_effect_wuerlixi_float, "configDict", nil)
end

return lua_fight_sp_effect_wuerlixi_float
