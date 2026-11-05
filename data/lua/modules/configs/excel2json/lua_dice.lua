-- chunkname: @modules/configs/excel2json/lua_dice.lua

module("modules.configs.excel2json.lua_dice", package.seeall)

local lua_dice = {}
local fields = {
	id = 1,
	suitList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice, "configList", _configList)
	rawset(lua_dice, "configDict", _configDict)
end

setmetatable(lua_dice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice, "configList", nil)
	rawset(lua_dice, "configDict", nil)
end

return lua_dice
