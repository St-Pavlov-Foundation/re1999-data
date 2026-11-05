-- chunkname: @modules/configs/excel2json/lua_rogue_ending.lua

module("modules.configs.excel2json.lua_rogue_ending", package.seeall)

local lua_rogue_ending = {}
local fields = {
	endingDesc = 6,
	resultIcon = 5,
	storyId = 3,
	id = 1,
	title = 2,
	endingIcon = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	endingDesc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rogue_ending_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_ending, "configList", _configList)
	rawset(lua_rogue_ending, "configDict", _configDict)
end

setmetatable(lua_rogue_ending, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_ending.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_ending, "configList", nil)
	rawset(lua_rogue_ending, "configDict", nil)
end

return lua_rogue_ending
