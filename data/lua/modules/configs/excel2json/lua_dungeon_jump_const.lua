-- chunkname: @modules/configs/excel2json/lua_dungeon_jump_const.lua

module("modules.configs.excel2json.lua_dungeon_jump_const", package.seeall)

local lua_dungeon_jump_const = {}
local fields = {
	id = 1,
	size = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dungeon_jump_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dungeon_jump_const, "configList", _configList)
	rawset(lua_dungeon_jump_const, "configDict", _configDict)
end

setmetatable(lua_dungeon_jump_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dungeon_jump_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dungeon_jump_const, "configList", nil)
	rawset(lua_dungeon_jump_const, "configDict", nil)
end

return lua_dungeon_jump_const
