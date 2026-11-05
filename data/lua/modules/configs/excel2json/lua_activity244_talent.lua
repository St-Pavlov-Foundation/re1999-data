-- chunkname: @modules/configs/excel2json/lua_activity244_talent.lua

module("modules.configs.excel2json.lua_activity244_talent", package.seeall)

local lua_activity244_talent = {}
local fields = {
	nodeIndex = 3,
	nodeId = 1,
	prevNodeId = 4,
	branch = 2,
	name = 10,
	desc = 8,
	costItemId = 5,
	teamCondition = 6,
	skillId = 7,
	icon = 9
}
local primaryKey = {
	"nodeId"
}
local mlStringKey = {
	name = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity244_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_talent, "configList", _configList)
	rawset(lua_activity244_talent, "configDict", _configDict)
end

setmetatable(lua_activity244_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_talent, "configList", nil)
	rawset(lua_activity244_talent, "configDict", nil)
end

return lua_activity244_talent
