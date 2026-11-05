-- chunkname: @modules/configs/excel2json/lua_fight_transition_act.lua

module("modules.configs.excel2json.lua_fight_transition_act", package.seeall)

local lua_fight_transition_act = {}
local fields = {
	fromAct = 2,
	id = 1,
	endAct = 3,
	transitionAct = 4
}
local primaryKey = {
	"id",
	"fromAct",
	"endAct"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_transition_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_transition_act, "configList", _configList)
	rawset(lua_fight_transition_act, "configDict", _configDict)
end

setmetatable(lua_fight_transition_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_transition_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_transition_act, "configList", nil)
	rawset(lua_fight_transition_act, "configDict", nil)
end

return lua_fight_transition_act
