-- chunkname: @modules/configs/excel2json/lua_partygame_pacman.lua

module("modules.configs.excel2json.lua_partygame_pacman", package.seeall)

local lua_partygame_pacman = {}
local fields = {
	interval = 5,
	numMax = 4,
	playerNum = 2,
	effect = 6,
	id = 1,
	refreshWeight = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_pacman_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_pacman, "configList", _configList)
	rawset(lua_partygame_pacman, "configDict", _configDict)
end

setmetatable(lua_partygame_pacman, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_pacman.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_pacman, "configList", nil)
	rawset(lua_partygame_pacman, "configDict", nil)
end

return lua_partygame_pacman
