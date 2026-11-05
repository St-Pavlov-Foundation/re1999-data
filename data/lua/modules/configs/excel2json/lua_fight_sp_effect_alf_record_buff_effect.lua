-- chunkname: @modules/configs/excel2json/lua_fight_sp_effect_alf_record_buff_effect.lua

module("modules.configs.excel2json.lua_fight_sp_effect_alf_record_buff_effect", package.seeall)

local lua_fight_sp_effect_alf_record_buff_effect = {}
local fields = {
	effect4 = 4,
	audio = 5,
	skinId = 1,
	effect3 = 3,
	effect2 = 2
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_effect_alf_record_buff_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_effect_alf_record_buff_effect, "configList", _configList)
	rawset(lua_fight_sp_effect_alf_record_buff_effect, "configDict", _configDict)
end

setmetatable(lua_fight_sp_effect_alf_record_buff_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_effect_alf_record_buff_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_effect_alf_record_buff_effect, "configList", nil)
	rawset(lua_fight_sp_effect_alf_record_buff_effect, "configDict", nil)
end

return lua_fight_sp_effect_alf_record_buff_effect
