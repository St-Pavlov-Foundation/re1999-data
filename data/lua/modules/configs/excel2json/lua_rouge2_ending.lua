-- chunkname: @modules/configs/excel2json/lua_rouge2_ending.lua

module("modules.configs.excel2json.lua_rouge2_ending", package.seeall)

local lua_rouge2_ending = {}
local fields = {
	id = 1,
	endingStoryId = 3,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_ending_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_ending, "configList", _configList)
	rawset(lua_rouge2_ending, "configDict", _configDict)
end

setmetatable(lua_rouge2_ending, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_ending.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_ending, "configList", nil)
	rawset(lua_rouge2_ending, "configDict", nil)
end

return lua_rouge2_ending
