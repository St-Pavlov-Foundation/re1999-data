-- chunkname: @modules/configs/excel2json/lua_fight_buff_replace_spine_act.lua

module("modules.configs.excel2json.lua_fight_buff_replace_spine_act", package.seeall)

local lua_fight_buff_replace_spine_act = {}
local fields = {
	combination = 4,
	priority = 3,
	buffId = 2,
	id = 1,
	suffix = 5
}
local primaryKey = {
	"id",
	"buffId",
	"priority"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_replace_spine_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_replace_spine_act, "configList", _configList)
	rawset(lua_fight_buff_replace_spine_act, "configDict", _configDict)
end

setmetatable(lua_fight_buff_replace_spine_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_replace_spine_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_replace_spine_act, "configList", nil)
	rawset(lua_fight_buff_replace_spine_act, "configDict", nil)
end

return lua_fight_buff_replace_spine_act
