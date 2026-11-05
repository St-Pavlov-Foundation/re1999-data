-- chunkname: @modules/configs/excel2json/lua_zongmao_boss_stage_buffid_effect.lua

module("modules.configs.excel2json.lua_zongmao_boss_stage_buffid_effect", package.seeall)

local lua_zongmao_boss_stage_buffid_effect = {}
local fields = {
	effects = 3,
	buffId = 2,
	id = 1,
	scales = 5,
	hangpoints = 4
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.zongmao_boss_stage_buffid_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_zongmao_boss_stage_buffid_effect, "configList", _configList)
	rawset(lua_zongmao_boss_stage_buffid_effect, "configDict", _configDict)
end

setmetatable(lua_zongmao_boss_stage_buffid_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_zongmao_boss_stage_buffid_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_zongmao_boss_stage_buffid_effect, "configList", nil)
	rawset(lua_zongmao_boss_stage_buffid_effect, "configDict", nil)
end

return lua_zongmao_boss_stage_buffid_effect
