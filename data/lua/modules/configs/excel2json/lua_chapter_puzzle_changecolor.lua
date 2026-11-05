-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_changecolor.lua

module("modules.configs.excel2json.lua_chapter_puzzle_changecolor", package.seeall)

local lua_chapter_puzzle_changecolor = {}
local fields = {
	interactbtns = 5,
	name = 2,
	colorsort = 6,
	id = 1,
	initColors = 3,
	finalColors = 4,
	bonus = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	initColors = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.chapter_puzzle_changecolor_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_puzzle_changecolor, "configList", _configList)
	rawset(lua_chapter_puzzle_changecolor, "configDict", _configDict)
end

setmetatable(lua_chapter_puzzle_changecolor, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_puzzle_changecolor.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_puzzle_changecolor, "configList", nil)
	rawset(lua_chapter_puzzle_changecolor, "configDict", nil)
end

return lua_chapter_puzzle_changecolor
