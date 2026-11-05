-- chunkname: @modules/configs/excel2json/lua_activity220_hsy_map.lua

module("modules.configs.excel2json.lua_activity220_hsy_map", package.seeall)

local lua_activity220_hsy_map = {}
local fields = {
	rolepos = 5,
	endpos = 6,
	enemy2Bpos = 8,
	mapid = 3,
	id = 2,
	resouce = 4,
	activityId = 1,
	enemy2Apos = 7
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_hsy_map_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_hsy_map, "configList", _configList)
	rawset(lua_activity220_hsy_map, "configDict", _configDict)
end

setmetatable(lua_activity220_hsy_map, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_hsy_map.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_hsy_map, "configList", nil)
	rawset(lua_activity220_hsy_map, "configDict", nil)
end

return lua_activity220_hsy_map
