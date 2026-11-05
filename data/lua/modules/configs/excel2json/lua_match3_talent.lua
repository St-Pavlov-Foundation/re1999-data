-- chunkname: @modules/configs/excel2json/lua_match3_talent.lua

module("modules.configs.excel2json.lua_match3_talent", package.seeall)

local lua_match3_talent = {}
local fields = {
	costItemId = 5,
	nodeId = 1,
	branch = 2,
	unlockCondition = 8,
	desc = 9,
	effectType = 6,
	prevNodeId = 4,
	nodeIndex = 3,
	effectParam = 7
}
local primaryKey = {
	"nodeId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.match3_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_match3_talent, "configList", _configList)
	rawset(lua_match3_talent, "configDict", _configDict)
end

setmetatable(lua_match3_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_match3_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_match3_talent, "configList", nil)
	rawset(lua_match3_talent, "configDict", nil)
end

return lua_match3_talent
