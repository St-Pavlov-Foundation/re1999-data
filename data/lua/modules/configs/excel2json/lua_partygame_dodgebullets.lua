-- chunkname: @modules/configs/excel2json/lua_partygame_dodgebullets.lua

module("modules.configs.excel2json.lua_partygame_dodgebullets", package.seeall)

local lua_partygame_dodgebullets = {}
local fields = {
	delay = 2,
	num = 3,
	id = 1,
	interval = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.partygame_dodgebullets_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_partygame_dodgebullets, "configList", _configList)
	rawset(lua_partygame_dodgebullets, "configDict", _configDict)
end

setmetatable(lua_partygame_dodgebullets, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_partygame_dodgebullets.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_partygame_dodgebullets, "configList", nil)
	rawset(lua_partygame_dodgebullets, "configDict", nil)
end

return lua_partygame_dodgebullets
