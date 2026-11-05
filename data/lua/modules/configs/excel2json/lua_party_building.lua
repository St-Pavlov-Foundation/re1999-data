-- chunkname: @modules/configs/excel2json/lua_party_building.lua

module("modules.configs.excel2json.lua_party_building", package.seeall)

local lua_party_building = {}
local fields = {
	scenePath = 6,
	name = 2,
	id = 1,
	icon = 5,
	pos = 4,
	enName = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.party_building_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_party_building, "configList", _configList)
	rawset(lua_party_building, "configDict", _configDict)
end

setmetatable(lua_party_building, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_party_building.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_party_building, "configList", nil)
	rawset(lua_party_building, "configDict", nil)
end

return lua_party_building
