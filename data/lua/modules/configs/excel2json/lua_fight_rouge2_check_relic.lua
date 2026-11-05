-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_check_relic.lua

module("modules.configs.excel2json.lua_fight_rouge2_check_relic", package.seeall)

local lua_fight_rouge2_check_relic = {}
local fields = {
	limit = 3,
	skill = 5,
	buff = 4,
	id = 1,
	attributeTag = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_rouge2_check_relic_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_rouge2_check_relic, "configList", _configList)
	rawset(lua_fight_rouge2_check_relic, "configDict", _configDict)
end

setmetatable(lua_fight_rouge2_check_relic, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_rouge2_check_relic.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_rouge2_check_relic, "configList", nil)
	rawset(lua_fight_rouge2_check_relic, "configDict", nil)
end

return lua_fight_rouge2_check_relic
