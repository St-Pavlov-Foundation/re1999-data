-- chunkname: @modules/configs/excel2json/lua_sodache_copy.lua

module("modules.configs.excel2json.lua_sodache_copy", package.seeall)

local lua_sodache_copy = {}
local fields = {
	faith = 12,
	name = 3,
	time = 11,
	type = 2,
	group = 4,
	image = 10,
	careerNum = 13,
	desc = 5,
	functionId = 7,
	mapId = 6,
	adoLv = 14,
	id = 1,
	icon = 9,
	price = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.sodache_copy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_copy, "configList", _configList)
	rawset(lua_sodache_copy, "configDict", _configDict)
end

setmetatable(lua_sodache_copy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_copy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_copy, "configList", nil)
	rawset(lua_sodache_copy, "configDict", nil)
end

return lua_sodache_copy
