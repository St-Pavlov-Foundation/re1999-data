-- chunkname: @modules/configs/excel2json/lua_critter_catalogue.lua

module("modules.configs.excel2json.lua_critter_catalogue", package.seeall)

local lua_critter_catalogue = {}
local fields = {
	parentId = 3,
	name = 4,
	type = 2,
	id = 1,
	baseCard = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.critter_catalogue_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_catalogue, "configList", _configList)
	rawset(lua_critter_catalogue, "configDict", _configDict)
end

setmetatable(lua_critter_catalogue, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_catalogue.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_catalogue, "configList", nil)
	rawset(lua_critter_catalogue, "configDict", nil)
end

return lua_critter_catalogue
