-- chunkname: @modules/configs/excel2json/lua_hero_upgrade.lua

module("modules.configs.excel2json.lua_hero_upgrade", package.seeall)

local lua_hero_upgrade = {}
local fields = {
	id = 1,
	heroId = 4,
	options = 3,
	type = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero_upgrade_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero_upgrade, "configList", _configList)
	rawset(lua_hero_upgrade, "configDict", _configDict)
end

setmetatable(lua_hero_upgrade, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero_upgrade.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero_upgrade, "configList", nil)
	rawset(lua_hero_upgrade, "configDict", nil)
end

return lua_hero_upgrade
