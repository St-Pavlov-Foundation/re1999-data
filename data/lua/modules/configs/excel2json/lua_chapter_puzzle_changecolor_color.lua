-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_changecolor_color.lua

module("modules.configs.excel2json.lua_chapter_puzzle_changecolor_color", package.seeall)

local lua_chapter_puzzle_changecolor_color = {}
local fields = {
	id = 1,
	name = 2,
	colorvalue = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.chapter_puzzle_changecolor_color_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_puzzle_changecolor_color, "configList", _configList)
	rawset(lua_chapter_puzzle_changecolor_color, "configDict", _configDict)
end

setmetatable(lua_chapter_puzzle_changecolor_color, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_puzzle_changecolor_color.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_puzzle_changecolor_color, "configList", nil)
	rawset(lua_chapter_puzzle_changecolor_color, "configDict", nil)
end

return lua_chapter_puzzle_changecolor_color
