-- chunkname: @modules/configs/excel2json/lua_auto_chess_mutation.lua

module("modules.configs.excel2json.lua_auto_chess_mutation", package.seeall)

local lua_auto_chess_mutation = {}
local fields = {
	name = 3,
	statusBuffId = 8,
	isOnline = 11,
	statusStyle = 7,
	sequence = 10,
	desc = 6,
	masterLibraryId = 4,
	skillId = 5,
	id = 1,
	icon = 9,
	activityId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.auto_chess_mutation_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_mutation, "configList", _configList)
	rawset(lua_auto_chess_mutation, "configDict", _configDict)
end

setmetatable(lua_auto_chess_mutation, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_mutation.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_mutation, "configList", nil)
	rawset(lua_auto_chess_mutation, "configDict", nil)
end

return lua_auto_chess_mutation
