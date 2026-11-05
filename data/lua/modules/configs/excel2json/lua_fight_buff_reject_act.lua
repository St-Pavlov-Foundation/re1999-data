-- chunkname: @modules/configs/excel2json/lua_fight_buff_reject_act.lua

module("modules.configs.excel2json.lua_fight_buff_reject_act", package.seeall)

local lua_fight_buff_reject_act = {}
local fields = {
	id = 1,
	rejectAct = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_reject_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_reject_act, "configList", _configList)
	rawset(lua_fight_buff_reject_act, "configDict", _configDict)
end

setmetatable(lua_fight_buff_reject_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_reject_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_reject_act, "configList", nil)
	rawset(lua_fight_buff_reject_act, "configDict", nil)
end

return lua_fight_buff_reject_act
