-- chunkname: @modules/configs/excel2json/lua_college_building.lua

module("modules.configs.excel2json.lua_college_building", package.seeall)

local lua_college_building = {}
local fields = {
	param = 8,
	name = 2,
	assetPath = 3,
	tags = 9,
	chessPos = 10,
	pos = 4,
	buildingType = 7,
	posOffset = 5,
	id = 1,
	rotation = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.college_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_building, "configList", _configList)
	rawset(lua_college_building, "configDict", _configDict)
end

setmetatable(lua_college_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_building, "configList", nil)
	rawset(lua_college_building, "configDict", nil)
end

return lua_college_building
