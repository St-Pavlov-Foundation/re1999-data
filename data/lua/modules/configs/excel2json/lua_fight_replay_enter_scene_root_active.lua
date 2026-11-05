-- chunkname: @modules/configs/excel2json/lua_fight_replay_enter_scene_root_active.lua

module("modules.configs.excel2json.lua_fight_replay_enter_scene_root_active", package.seeall)

local lua_fight_replay_enter_scene_root_active = {}
local fields = {
	wave = 2,
	id = 1,
	activeRootName = 3,
	switch = 4
}
local primaryKey = {
	"id",
	"wave"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_replay_enter_scene_root_active_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_replay_enter_scene_root_active, "configList", _configList)
	rawset(lua_fight_replay_enter_scene_root_active, "configDict", _configDict)
end

setmetatable(lua_fight_replay_enter_scene_root_active, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_replay_enter_scene_root_active.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_replay_enter_scene_root_active, "configList", nil)
	rawset(lua_fight_replay_enter_scene_root_active, "configDict", nil)
end

return lua_fight_replay_enter_scene_root_active
