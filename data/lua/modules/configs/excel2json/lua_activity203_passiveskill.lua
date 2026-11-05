-- chunkname: @modules/configs/excel2json/lua_activity203_passiveskill.lua

module("modules.configs.excel2json.lua_activity203_passiveskill", package.seeall)

local lua_activity203_passiveskill = {}
local fields = {
	description = 3,
	passive_skillid = 1,
	name = 2,
	effect = 4
}
local primaryKey = {
	"passive_skillid"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity203_passiveskill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity203_passiveskill, "configList", _configList)
	rawset(lua_activity203_passiveskill, "configDict", _configDict)
end

setmetatable(lua_activity203_passiveskill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity203_passiveskill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity203_passiveskill, "configList", nil)
	rawset(lua_activity203_passiveskill, "configDict", nil)
end

return lua_activity203_passiveskill
