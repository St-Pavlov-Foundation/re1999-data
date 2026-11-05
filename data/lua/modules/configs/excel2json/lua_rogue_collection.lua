-- chunkname: @modules/configs/excel2json/lua_rogue_collection.lua

module("modules.configs.excel2json.lua_rogue_collection", package.seeall)

local lua_rogue_collection = {}
local fields = {
	skills = 12,
	name = 2,
	group = 10,
	type = 3,
	eventGroupWeights = 17,
	dropGroupWeights = 19,
	unlockTask = 20,
	desc = 13,
	inHandBook = 21,
	statetype = 8,
	icon = 9,
	spdesc = 14,
	attr = 11,
	shopWeights = 18,
	holeNum = 6,
	showRare = 5,
	rare = 4,
	unique = 7,
	heartbeatRange = 15,
	eventWeights = 16,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1,
	spdesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rogue_collection_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_collection, "configList", _configList)
	rawset(lua_rogue_collection, "configDict", _configDict)
end

setmetatable(lua_rogue_collection, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_collection.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_collection, "configList", nil)
	rawset(lua_rogue_collection, "configDict", nil)
end

return lua_rogue_collection
