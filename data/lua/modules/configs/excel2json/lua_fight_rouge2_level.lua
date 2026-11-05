-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_level.lua

module("modules.configs.excel2json.lua_fight_rouge2_level", package.seeall)

local lua_fight_rouge2_level = {}
local fields = {
	id = 1,
	icon = 4,
	rare = 2,
	bgIcon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_rouge2_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_rouge2_level, "configList", _configList)
	rawset(lua_fight_rouge2_level, "configDict", _configDict)
end

setmetatable(lua_fight_rouge2_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_rouge2_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_rouge2_level, "configList", nil)
	rawset(lua_fight_rouge2_level, "configDict", nil)
end

return lua_fight_rouge2_level
