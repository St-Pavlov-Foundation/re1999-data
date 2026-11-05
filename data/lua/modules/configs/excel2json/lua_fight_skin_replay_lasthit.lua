-- chunkname: @modules/configs/excel2json/lua_fight_skin_replay_lasthit.lua

module("modules.configs.excel2json.lua_fight_skin_replay_lasthit", package.seeall)

local lua_fight_skin_replay_lasthit = {}
local fields = {
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_skin_replay_lasthit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_skin_replay_lasthit, "configList", _configList)
	rawset(lua_fight_skin_replay_lasthit, "configDict", _configDict)
end

setmetatable(lua_fight_skin_replay_lasthit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_skin_replay_lasthit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_skin_replay_lasthit, "configList", nil)
	rawset(lua_fight_skin_replay_lasthit, "configDict", nil)
end

return lua_fight_skin_replay_lasthit
