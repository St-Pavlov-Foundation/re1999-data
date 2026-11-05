-- chunkname: @modules/configs/excel2json/lua_rogue_event_fight.lua

module("modules.configs.excel2json.lua_rogue_event_fight", package.seeall)

local lua_rogue_event_fight = {}
local fields = {
	heartChange5 = 8,
	heartChange4 = 7,
	attrChange1 = 9,
	type = 3,
	oldtemplate = 14,
	attrChange2 = 10,
	episode = 2,
	attrChange3 = 11,
	attrChange5 = 13,
	attrChange4 = 12,
	newtemplate = 15,
	heartChange1 = 4,
	id = 1,
	heartChange2 = 5,
	isChangeScene = 16,
	heartChange3 = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_event_fight_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_event_fight, "configList", _configList)
	rawset(lua_rogue_event_fight, "configDict", _configDict)
end

setmetatable(lua_rogue_event_fight, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_event_fight.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_event_fight, "configList", nil)
	rawset(lua_rogue_event_fight, "configDict", nil)
end

return lua_rogue_event_fight
