-- chunkname: @modules/configs/excel2json/lua_handbook_character_age.lua

module("modules.configs.excel2json.lua_handbook_character_age", package.seeall)

local lua_handbook_character_age = {}
local fields = {
	id = 1,
	image = 3,
	rewardIcon = 4,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.handbook_character_age_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_character_age, "configList", _configList)
	rawset(lua_handbook_character_age, "configDict", _configDict)
end

setmetatable(lua_handbook_character_age, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_character_age.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_character_age, "configList", nil)
	rawset(lua_handbook_character_age, "configDict", nil)
end

return lua_handbook_character_age
