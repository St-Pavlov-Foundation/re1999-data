-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_ddg.lua

module("modules.configs.excel2json.lua_fight_sp_effect_ddg", package.seeall)

local lua_fight_sp_effect_ddg = {}
local fields = {
	addExPointEffect = 2,
	addExPointHang = 3,
	posionHang = 5,
	skinId = 1,
	posionEffect = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_ddg_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_ddg, "configList", _configList)
	rawset(lua_fight_sp_effect_ddg, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_ddg, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_ddg.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_ddg, "configList", nil)
	rawset(lua_fight_sp_effect_ddg, "configDict", nil)
end

return lua_fight_sp_effect_ddg
