-- chunkname: @modules/configs/excel2json/lua_partygame_puzzle_pictures.lua

module("modules.configs.excel2json.lua_partygame_puzzle_pictures", package.seeall)

local lua_partygame_puzzle_pictures = {}
local fields = {
	id = 1,
	resource = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_puzzle_pictures_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_puzzle_pictures, "configList", _configList)
	rawset(lua_partygame_puzzle_pictures, "configDict", _configDict)
end

setmetatable(lua_partygame_puzzle_pictures, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_puzzle_pictures.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_puzzle_pictures, "configList", nil)
	rawset(lua_partygame_puzzle_pictures, "configDict", nil)
end

return lua_partygame_puzzle_pictures
