-- chunkname: @modules/configs/excel2json/lua_college_actor_growth.lua

module("modules.configs.excel2json.lua_college_actor_growth", package.seeall)

local lua_college_actor_growth = {}
local fields = {
	cost = 3,
	entryPool = 5,
	id = 1,
	dismissReward = 4,
	level = 2
}
local primaryKey = {
	"id",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.college_actor_growth_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_actor_growth, "configList", _configList)
	rawset(lua_college_actor_growth, "configDict", _configDict)
end

setmetatable(lua_college_actor_growth, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_actor_growth.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_actor_growth, "configList", nil)
	rawset(lua_college_actor_growth, "configDict", nil)
end

return lua_college_actor_growth
