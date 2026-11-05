-- chunkname: @modules/configs/excel2json/lua_dice_pattern.lua

module("modules.configs.excel2json.lua_dice_pattern", package.seeall)

local lua_dice_pattern = {}
local fields = {
	id = 1,
	patternList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dice_pattern_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_pattern, "configList", _configList)
	rawset(lua_dice_pattern, "configDict", _configDict)
end

setmetatable(lua_dice_pattern, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_pattern.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_pattern, "configList", nil)
	rawset(lua_dice_pattern, "configDict", nil)
end

return lua_dice_pattern
