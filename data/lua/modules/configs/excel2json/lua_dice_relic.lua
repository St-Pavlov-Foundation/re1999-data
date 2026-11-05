-- chunkname: @modules/configs/excel2json/lua_dice_relic.lua

module("modules.configs.excel2json.lua_dice_relic", package.seeall)

local lua_dice_relic = {}
local fields = {
	param = 6,
	name = 2,
	effect = 5,
	id = 1,
	icon = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.dice_relic_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_relic, "configList", _configList)
	rawset(lua_dice_relic, "configDict", _configDict)
end

setmetatable(lua_dice_relic, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_relic.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_relic, "configList", nil)
	rawset(lua_dice_relic, "configDict", nil)
end

return lua_dice_relic
