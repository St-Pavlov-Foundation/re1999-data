-- chunkname: @modules/configs/excel2json/lua_auto_chess_collection.lua

module("modules.configs.excel2json.lua_auto_chess_collection", package.seeall)

local lua_auto_chess_collection = {}
local fields = {
	isSp = 9,
	name = 2,
	skilldesc = 5,
	id = 1,
	passiveChessSkills = 4,
	image = 8,
	quality = 10,
	desc = 3,
	tag = 6,
	weight = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	skilldesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.auto_chess_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_collection, "configList", _configList)
	rawset(lua_auto_chess_collection, "configDict", _configDict)
end

setmetatable(lua_auto_chess_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_collection, "configList", nil)
	rawset(lua_auto_chess_collection, "configDict", nil)
end

return lua_auto_chess_collection
