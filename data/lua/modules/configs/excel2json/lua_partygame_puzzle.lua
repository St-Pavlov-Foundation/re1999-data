-- chunkname: @modules/configs/excel2json/lua_partygame_puzzle.lua

module("modules.configs.excel2json.lua_partygame_puzzle", package.seeall)

local lua_partygame_puzzle = {}
local fields = {
	id = 1,
	pictureIds = 3,
	answerTime = 2,
	exchange = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_puzzle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_puzzle, "configList", _configList)
	rawset(lua_partygame_puzzle, "configDict", _configDict)
end

setmetatable(lua_partygame_puzzle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_puzzle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_puzzle, "configList", nil)
	rawset(lua_partygame_puzzle, "configDict", nil)
end

return lua_partygame_puzzle
