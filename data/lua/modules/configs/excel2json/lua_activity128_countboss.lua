-- chunkname: @modules/configs/excel2json/lua_activity128_countboss.lua

module("modules.configs.excel2json.lua_activity128_countboss", package.seeall)

local lua_activity128_countboss = {}
local fields = {
	battleId = 1,
	monsterId = 2,
	maxPoints = 4,
	finalMonsterId = 3
}
local primaryKey = {
	"battleId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity128_countboss_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_countboss, "configList", _configList)
	rawset(lua_activity128_countboss, "configDict", _configDict)
end

setmetatable(lua_activity128_countboss, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_countboss.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_countboss, "configList", nil)
	rawset(lua_activity128_countboss, "configDict", nil)
end

return lua_activity128_countboss
