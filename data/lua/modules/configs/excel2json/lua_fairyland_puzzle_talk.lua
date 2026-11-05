-- chunkname: @modules/configs/excel2json/lua_fairyland_puzzle_talk.lua

module("modules.configs.excel2json.lua_fairyland_puzzle_talk", package.seeall)

local lua_fairyland_puzzle_talk = {}
local fields = {
	param = 4,
	audioId = 5,
	speaker = 6,
	type = 3,
	id = 1,
	elementId = 8,
	content = 7,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	speaker = 1,
	content = 2
}
local _configList, _configDict
local configPath = "configs.fairyland_puzzle_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fairyland_puzzle_talk, "configList", _configList)
	rawset(lua_fairyland_puzzle_talk, "configDict", _configDict)
end

setmetatable(lua_fairyland_puzzle_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fairyland_puzzle_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fairyland_puzzle_talk, "configList", nil)
	rawset(lua_fairyland_puzzle_talk, "configDict", nil)
end

return lua_fairyland_puzzle_talk
