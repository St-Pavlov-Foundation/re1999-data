-- chunkname: @modules/configs/excel2json/lua_fairyland_puzzle.lua

module("modules.configs.excel2json.lua_fairyland_puzzle", package.seeall)

local lua_fairyland_puzzle = {}
local fields = {
	id = 1,
	afterTalkId = 5,
	errorTalkId = 8,
	beforeTalkId = 4,
	storyTalkId = 9,
	elementId = 3,
	successTalkId = 6,
	tipsTalkId = 7,
	answer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fairyland_puzzle_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fairyland_puzzle, "configList", _configList)
	rawset(lua_fairyland_puzzle, "configDict", _configDict)
end

setmetatable(lua_fairyland_puzzle, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fairyland_puzzle.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fairyland_puzzle, "configList", nil)
	rawset(lua_fairyland_puzzle, "configDict", nil)
end

return lua_fairyland_puzzle
