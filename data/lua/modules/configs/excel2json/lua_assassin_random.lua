-- chunkname: @modules/configs/excel2json/lua_assassin_random.lua

module("modules.configs.excel2json.lua_assassin_random", package.seeall)

local lua_assassin_random = {}
local fields = {
	param = 4,
	name = 5,
	img = 6,
	type = 3,
	id = 1,
	weight = 2,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.assassin_random_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_random, "configList", _configList)
	rawset(lua_assassin_random, "configDict", _configDict)
end

setmetatable(lua_assassin_random, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_random.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_random, "configList", nil)
	rawset(lua_assassin_random, "configDict", nil)
end

return lua_assassin_random
