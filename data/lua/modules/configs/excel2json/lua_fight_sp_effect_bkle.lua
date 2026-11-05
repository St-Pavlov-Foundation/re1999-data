-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_bkle.lua

module("modules.configs.excel2json.lua_fight_sp_effect_bkle", package.seeall)

local lua_fight_sp_effect_bkle = {}
local fields = {
	audio = 5,
	buffId = 2,
	hangPoint = 4,
	id = 1,
	path = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_bkle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_bkle, "configList", _configList)
	rawset(lua_fight_sp_effect_bkle, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_bkle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_bkle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_bkle, "configList", nil)
	rawset(lua_fight_sp_effect_bkle, "configDict", nil)
end

return lua_fight_sp_effect_bkle
