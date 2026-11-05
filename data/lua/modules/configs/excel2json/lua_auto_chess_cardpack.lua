-- chunkname: @modules/configs/excel2json/lua_auto_chess_cardpack.lua

module("modules.configs.excel2json.lua_auto_chess_cardpack", package.seeall)

local lua_auto_chess_cardpack = {}
local fields = {
	activityId = 1,
	name = 3,
	races = 10,
	sequence = 4,
	desc = 8,
	chessPool = 5,
	masterLibraryId = 6,
	id = 2,
	icon = 9,
	collectionPool = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.auto_chess_cardpack_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_cardpack, "configList", _configList)
	rawset(lua_auto_chess_cardpack, "configDict", _configDict)
end

setmetatable(lua_auto_chess_cardpack, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_cardpack.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_cardpack, "configList", nil)
	rawset(lua_auto_chess_cardpack, "configDict", nil)
end

return lua_auto_chess_cardpack
