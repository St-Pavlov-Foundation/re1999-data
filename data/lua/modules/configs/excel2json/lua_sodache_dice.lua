-- chunkname: @modules/configs/excel2json/lua_sodache_dice.lua

module("modules.configs.excel2json.lua_sodache_dice", package.seeall)

local lua_sodache_dice = {}
local fields = {
	id = 1,
	faceList = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.sodache_dice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_dice, "configList", _configList)
	rawset(lua_sodache_dice, "configDict", _configDict)
end

setmetatable(lua_sodache_dice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_dice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_dice, "configList", nil)
	rawset(lua_sodache_dice, "configDict", nil)
end

return lua_sodache_dice
