-- chunkname: @modules/configs/excel2json/lua_tower_permanent_time.lua

module("modules.configs.excel2json.lua_tower_permanent_time", package.seeall)

local lua_tower_permanent_time = {}
local fields = {
	stageId = 1,
	name = 3,
	time = 2,
	nameEn = 4
}
local primaryKey = {
	"stageId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.tower_permanent_time_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_permanent_time, "configList", _configList)
	rawset(lua_tower_permanent_time, "configDict", _configDict)
end

setmetatable(lua_tower_permanent_time, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_permanent_time.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_permanent_time, "configList", nil)
	rawset(lua_tower_permanent_time, "configDict", nil)
end

return lua_tower_permanent_time
