-- chunkname: @modules/configs/excel2json/lua_auto_chess_level.lua

module("modules.configs.excel2json.lua_auto_chess_level", package.seeall)

local lua_auto_chess_level = {}
local fields = {
	collectionIds = 8,
	unlockCollectionIds = 7,
	unlockBossIds = 6,
	unlockCardpackIds = 5,
	exp = 3,
	bonus = 4,
	spMasterId = 9,
	activityId = 1,
	level = 2
}
local primaryKey = {
	"activityId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_level, "configList", _configList)
	rawset(lua_auto_chess_level, "configDict", _configDict)
end

setmetatable(lua_auto_chess_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_level, "configList", nil)
	rawset(lua_auto_chess_level, "configDict", nil)
end

return lua_auto_chess_level
