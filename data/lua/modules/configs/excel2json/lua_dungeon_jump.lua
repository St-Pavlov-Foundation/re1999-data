-- chunkname: @modules/configs/excel2json/lua_dungeon_jump.lua

module("modules.configs.excel2json.lua_dungeon_jump", package.seeall)

local lua_dungeon_jump = {}
local fields = {
	isflag = 7,
	celltype = 4,
	coord = 3,
	cellspecies = 6,
	id = 1,
	cellId = 2,
	evenid = 5
}
local primaryKey = {
	"id",
	"cellId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dungeon_jump_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dungeon_jump, "configList", _configList)
	rawset(lua_dungeon_jump, "configDict", _configDict)
end

setmetatable(lua_dungeon_jump, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dungeon_jump.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dungeon_jump, "configList", nil)
	rawset(lua_dungeon_jump, "configDict", nil)
end

return lua_dungeon_jump
