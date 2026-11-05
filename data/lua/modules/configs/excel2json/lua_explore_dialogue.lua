-- chunkname: @modules/configs/excel2json/lua_explore_dialogue.lua

module("modules.configs.excel2json.lua_explore_dialogue", package.seeall)

local lua_explore_dialogue = {}
local fields = {
	refuseButton = 8,
	bonusButton = 9,
	selectButton = 10,
	audio = 5,
	picture = 11,
	interrupt = 3,
	desc = 6,
	speaker = 4,
	id = 1,
	acceptButton = 7,
	stepid = 2
}
local primaryKey = {
	"id",
	"stepid"
}
local mlStringKey = {
	refuseButton = 4,
	speaker = 1,
	bonusButton = 5,
	selectButton = 6,
	acceptButton = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.explore_dialogue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_explore_dialogue, "configList", _configList)
	rawset(lua_explore_dialogue, "configDict", _configDict)
end

setmetatable(lua_explore_dialogue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_explore_dialogue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_explore_dialogue, "configList", nil)
	rawset(lua_explore_dialogue, "configDict", nil)
end

return lua_explore_dialogue
