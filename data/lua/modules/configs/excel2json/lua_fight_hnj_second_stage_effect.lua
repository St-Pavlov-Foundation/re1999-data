-- chunkname: @modules/configs/excel2json/lua_fight_hnj_second_stage_effect.lua

module("modules.configs.excel2json.lua_fight_hnj_second_stage_effect", package.seeall)

local lua_fight_hnj_second_stage_effect = {}
local fields = {
	effect = 2,
	skinId = 1
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_hnj_second_stage_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_hnj_second_stage_effect, "configList", _configList)
	rawset(lua_fight_hnj_second_stage_effect, "configDict", _configDict)
end

setmetatable(lua_fight_hnj_second_stage_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_hnj_second_stage_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_hnj_second_stage_effect, "configList", nil)
	rawset(lua_fight_hnj_second_stage_effect, "configDict", nil)
end

return lua_fight_hnj_second_stage_effect
