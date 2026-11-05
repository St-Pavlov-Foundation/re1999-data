-- chunkname: @modules/configs/excel2json/lua_dice_point.lua

module("modules.configs.excel2json.lua_dice_point", package.seeall)

local lua_dice_point = {}
local fields = {
	id = 1,
	pointList = 2,
	txt = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.dice_point_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_point, "configList", _configList)
	rawset(lua_dice_point, "configDict", _configDict)
end

setmetatable(lua_dice_point, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_point.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_point, "configList", nil)
	rawset(lua_dice_point, "configDict", nil)
end

return lua_dice_point
