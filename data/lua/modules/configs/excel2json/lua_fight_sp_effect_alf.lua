-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf", package.seeall)

local lua_fight_sp_effect_alf = {}
local fields = {
	pullOutRes = 4,
	resName = 1,
	audioId = 5,
	skinId = 2,
	residualRes = 3
}
local primaryKey = {
	"resName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_alf_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_alf, "configList", _configList)
	rawset(lua_fight_sp_effect_alf, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_alf, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_alf.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_alf, "configList", nil)
	rawset(lua_fight_sp_effect_alf, "configDict", nil)
end

return lua_fight_sp_effect_alf
