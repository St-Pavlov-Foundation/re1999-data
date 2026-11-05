-- chunkname: @modules/configs/excel2json/lua_block_resource.lua

module("modules.configs.excel2json.lua_block_resource", package.seeall)

local lua_block_resource = {}
local fields = {
	itemId = 4,
	name = 2,
	occupied = 6,
	vehicleId = 10,
	path = 3,
	placeBuilding = 9,
	numLimit = 8,
	buildingFilter = 5,
	id = 1,
	blockLight = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.block_resource_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_block_resource, "configList", _configList)
	rawset(lua_block_resource, "configDict", _configDict)
end

setmetatable(lua_block_resource, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_resource.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_resource, "configList", nil)
	rawset(lua_block_resource, "configDict", nil)
end

return lua_block_resource
