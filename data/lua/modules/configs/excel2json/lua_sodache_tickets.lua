-- chunkname: @modules/configs/excel2json/lua_sodache_tickets.lua

module("modules.configs.excel2json.lua_sodache_tickets", package.seeall)

local lua_sodache_tickets = {}
local fields = {
	tips = 3,
	name = 2,
	price = 5,
	skillIds = 6,
	id = 1,
	pic = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.sodache_tickets_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_tickets, "configList", _configList)
	rawset(lua_sodache_tickets, "configDict", _configDict)
end

setmetatable(lua_sodache_tickets, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_tickets.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_tickets, "configList", nil)
	rawset(lua_sodache_tickets, "configDict", nil)
end

return lua_sodache_tickets
