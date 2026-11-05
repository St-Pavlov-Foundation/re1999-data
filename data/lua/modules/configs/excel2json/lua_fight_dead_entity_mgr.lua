-- chunkname: @modules/configs/excel2json/lua_fight_dead_entity_mgr.lua

module("modules.configs.excel2json.lua_fight_dead_entity_mgr", package.seeall)

local lua_fight_dead_entity_mgr = {}
local fields = {
	id = 1,
	playTime = 3,
	loopActName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_dead_entity_mgr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_dead_entity_mgr, "configList", _configList)
	rawset(lua_fight_dead_entity_mgr, "configDict", _configDict)
end

setmetatable(lua_fight_dead_entity_mgr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_dead_entity_mgr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_dead_entity_mgr, "configList", nil)
	rawset(lua_fight_dead_entity_mgr, "configDict", nil)
end

return lua_fight_dead_entity_mgr
