-- chunkname: @modules/configs/excel2json/lua_fight_sswl_skill1_effect.lua

module("modules.configs.excel2json.lua_fight_sswl_skill1_effect", package.seeall)

local lua_fight_sswl_skill1_effect = {}
local fields = {
	id = 1,
	buffId = 2,
	timeline = 3
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sswl_skill1_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sswl_skill1_effect, "configList", _configList)
	rawset(lua_fight_sswl_skill1_effect, "configDict", _configDict)
end

setmetatable(lua_fight_sswl_skill1_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sswl_skill1_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sswl_skill1_effect, "configList", nil)
	rawset(lua_fight_sswl_skill1_effect, "configDict", nil)
end

return lua_fight_sswl_skill1_effect
