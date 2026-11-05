-- chunkname: @modules/configs/excel2json/lua_fight_she_fa_ignite.lua

module("modules.configs.excel2json.lua_fight_she_fa_ignite", package.seeall)

local lua_fight_she_fa_ignite = {}
local fields = {
	id = 1,
	timeline = 3,
	layer = 2
}
local primaryKey = {
	"id",
	"layer"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_she_fa_ignite_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_she_fa_ignite, "configList", _configList)
	rawset(lua_fight_she_fa_ignite, "configDict", _configDict)
end

setmetatable(lua_fight_she_fa_ignite, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_she_fa_ignite.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_she_fa_ignite, "configList", nil)
	rawset(lua_fight_she_fa_ignite, "configDict", nil)
end

return lua_fight_she_fa_ignite
