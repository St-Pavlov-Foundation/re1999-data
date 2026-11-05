-- chunkname: @modules/configs/excel2json/lua_activity226_boxlist.lua

module("modules.configs.excel2json.lua_activity226_boxlist", package.seeall)

local lua_activity226_boxlist = {}
local fields = {
	cardId = 2,
	id = 3,
	bonusWeight = 5,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"cardId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity226_boxlist_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity226_boxlist, "configList", _configList)
	rawset(lua_activity226_boxlist, "configDict", _configDict)
end

setmetatable(lua_activity226_boxlist, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity226_boxlist.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity226_boxlist, "configList", nil)
	rawset(lua_activity226_boxlist, "configDict", nil)
end

return lua_activity226_boxlist
