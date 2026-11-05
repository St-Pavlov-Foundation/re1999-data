-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_relic_type.lua

module("modules.configs.excel2json.lua_fight_rouge2_relic_type", package.seeall)

local lua_fight_rouge2_relic_type = {}
local fields = {
	bigIcon = 3,
	color = 5,
	id = 1,
	icon = 4,
	progressIcon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_rouge2_relic_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_rouge2_relic_type, "configList", _configList)
	rawset(lua_fight_rouge2_relic_type, "configDict", _configDict)
end

setmetatable(lua_fight_rouge2_relic_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_rouge2_relic_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_rouge2_relic_type, "configList", nil)
	rawset(lua_fight_rouge2_relic_type, "configDict", nil)
end

return lua_fight_rouge2_relic_type
