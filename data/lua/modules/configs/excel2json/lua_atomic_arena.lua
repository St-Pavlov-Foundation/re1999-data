-- chunkname: @modules/configs/excel2json/lua_atomic_arena.lua

module("modules.configs.excel2json.lua_atomic_arena", package.seeall)

local lua_atomic_arena = {}
local fields = {
	unlockSeq = 2,
	arenaId = 1,
	scale = 3
}
local primaryKey = {
	"arenaId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.atomic_arena_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_arena, "configList", _configList)
	rawset(lua_atomic_arena, "configDict", _configDict)
end

setmetatable(lua_atomic_arena, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_arena.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_arena, "configList", nil)
	rawset(lua_atomic_arena, "configDict", nil)
end

return lua_atomic_arena
