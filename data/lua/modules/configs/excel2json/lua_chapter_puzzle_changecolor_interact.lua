-- chunkname: @modules/configs/excel2json/lua_chapter_puzzle_changecolor_interact.lua

module("modules.configs.excel2json.lua_chapter_puzzle_changecolor_interact", package.seeall)

local lua_chapter_puzzle_changecolor_interact = {}
local fields = {
	id = 1,
	interactvalue = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.chapter_puzzle_changecolor_interact_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_chapter_puzzle_changecolor_interact, "configList", _configList)
	rawset(lua_chapter_puzzle_changecolor_interact, "configDict", _configDict)
end

setmetatable(lua_chapter_puzzle_changecolor_interact, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_chapter_puzzle_changecolor_interact.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_chapter_puzzle_changecolor_interact, "configList", nil)
	rawset(lua_chapter_puzzle_changecolor_interact, "configDict", nil)
end

return lua_chapter_puzzle_changecolor_interact
