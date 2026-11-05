-- chunkname: @modules/configs/excel2json/lua_dice_suit.lua

module("modules.configs.excel2json.lua_dice_suit", package.seeall)

local lua_dice_suit = {}
local fields = {
	id = 1,
	icon = 3,
	suit = 2,
	icon2 = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dice_suit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_suit, "configList", _configList)
	rawset(lua_dice_suit, "configDict", _configDict)
end

setmetatable(lua_dice_suit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_suit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_suit, "configList", nil)
	rawset(lua_dice_suit, "configDict", nil)
end

return lua_dice_suit
