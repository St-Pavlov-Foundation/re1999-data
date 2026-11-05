-- chunkname: @modules/configs/excel2json/lua_college_location.lua

module("modules.configs.excel2json.lua_college_location", package.seeall)

local lua_college_location = {}
local fields = {
	param = 8,
	progressPerStep = 5,
	requiredProgress = 6,
	tags = 11,
	skillIds = 9,
	name = 2,
	pos = 3,
	description = 12,
	turnsPerStep = 4,
	locationType = 7,
	id = 1,
	slots = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.college_location_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_location, "configList", _configList)
	rawset(lua_college_location, "configDict", _configDict)
end

setmetatable(lua_college_location, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_location.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_location, "configList", nil)
	rawset(lua_college_location, "configDict", nil)
end

return lua_college_location
