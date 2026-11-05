-- chunkname: @modules/configs/excel2json/lua_activity203_base.lua

module("modules.configs.excel2json.lua_activity203_base", package.seeall)

local lua_activity203_base = {}
local fields = {
	dispatchInterval = 7,
	name = 2,
	initialCamp = 6,
	type = 4,
	baseId = 1,
	picture = 3,
	isHQ = 5,
	initialSoldier = 8,
	soldierRecover = 9,
	soldierLimit = 10
}
local primaryKey = {
	"baseId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity203_base_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity203_base, "configList", _configList)
	rawset(lua_activity203_base, "configDict", _configDict)
end

setmetatable(lua_activity203_base, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity203_base.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity203_base, "configList", nil)
	rawset(lua_activity203_base, "configDict", nil)
end

return lua_activity203_base
