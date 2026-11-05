-- chunkname: @modules/configs/excel2json/lua_arcade_survivor_handbook.lua

module("modules.configs.excel2json.lua_arcade_survivor_handbook", package.seeall)

local lua_arcade_survivor_handbook = {}
local fields = {
	order = 3,
	eleId = 1,
	category = 2
}
local primaryKey = {
	"eleId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_survivor_handbook_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_survivor_handbook, "configList", _configList)
	rawset(lua_arcade_survivor_handbook, "configDict", _configDict)
end

setmetatable(lua_arcade_survivor_handbook, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_survivor_handbook.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_survivor_handbook, "configList", nil)
	rawset(lua_arcade_survivor_handbook, "configDict", nil)
end

return lua_arcade_survivor_handbook
