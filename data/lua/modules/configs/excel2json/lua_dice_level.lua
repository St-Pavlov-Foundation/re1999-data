-- chunkname: @modules/configs/excel2json/lua_dice_level.lua

module("modules.configs.excel2json.lua_dice_level", package.seeall)

local lua_dice_level = {}
local fields = {
	chapter = 3,
	enemyType = 6,
	isSkip = 10,
	type = 5,
	rewardSelectType = 8,
	mode = 7,
	room = 4,
	dialog = 9,
	id = 1,
	chapterName = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	chapterName = 1
}
local _configList, _configDict
local configPath = "configs.dice_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_dice_level, "configList", _configList)
	rawset(lua_dice_level, "configDict", _configDict)
end

setmetatable(lua_dice_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_dice_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_dice_level, "configList", nil)
	rawset(lua_dice_level, "configDict", nil)
end

return lua_dice_level
