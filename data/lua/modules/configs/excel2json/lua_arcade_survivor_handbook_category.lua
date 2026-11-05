-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_handbook_category.lua

module("modules.configs.excel2json.lua_arcade_survivor_handbook_category", package.seeall)

local lua_arcade_survivor_handbook_category = {}
local fields = {
	id = 1,
	title = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.arcade_survivor_handbook_category_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_handbook_category, "configList", _configList)
	rawset(lua_arcade_survivor_handbook_category, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_handbook_category, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_handbook_category.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_handbook_category, "configList", nil)
	rawset(lua_arcade_survivor_handbook_category, "configDict", nil)
end

return lua_arcade_survivor_handbook_category
