-- chunkname: @modules/configs/excel2json/lua_arcade_room.lua

module("modules.configs.excel2json.lua_arcade_room", package.seeall)

local lua_arcade_room = {}
local fields = {
	dropMethod = 3,
	initMonster = 8,
	initFloor = 10,
	roomType = 2,
	initInteractive = 9,
	monsterwaves = 5,
	spMonster = 7,
	waveInterval = 6,
	monsterGroupIds = 4,
	skills = 12,
	id = 1,
	nodePortalCoordinates = 11
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_room_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_room, "configList", _configList)
	rawset(lua_arcade_room, "configDict", _configDict)
end

setmetatable(lua_arcade_room, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_room.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_room, "configList", nil)
	rawset(lua_arcade_room, "configDict", nil)
end

return lua_arcade_room
