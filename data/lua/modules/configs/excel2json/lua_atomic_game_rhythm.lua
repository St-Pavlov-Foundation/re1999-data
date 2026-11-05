-- chunkname: @modules/configs/excel2json/lua_atomic_game_rhythm.lua

module("modules.configs.excel2json.lua_atomic_game_rhythm", package.seeall)

local lua_atomic_game_rhythm = {}
local fields = {
	point = 2,
	time = 3,
	id = 1,
	title = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.atomic_game_rhythm_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_game_rhythm, "configList", _configList)
	rawset(lua_atomic_game_rhythm, "configDict", _configDict)
end

setmetatable(lua_atomic_game_rhythm, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_game_rhythm.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_game_rhythm, "configList", nil)
	rawset(lua_atomic_game_rhythm, "configDict", nil)
end

return lua_atomic_game_rhythm
