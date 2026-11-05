-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_square.lua

module("modules.configs.excel2json.lua_chapter_puzzle_square", package.seeall)

local lua_chapter_puzzle_square = {}
local fields = {
	id = 1,
	shape = 2,
	count = 3,
	group = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.chapter_puzzle_square_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_puzzle_square, "configList", _configList)
	rawset(lua_chapter_puzzle_square, "configDict", _configDict)
end

setmetatable(lua_chapter_puzzle_square, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_puzzle_square.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_puzzle_square, "configList", nil)
	rawset(lua_chapter_puzzle_square, "configDict", nil)
end

return lua_chapter_puzzle_square
