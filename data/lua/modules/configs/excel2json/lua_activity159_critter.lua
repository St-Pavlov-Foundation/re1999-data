-- chunkname: @modules/configs/excel2json/lua_activity159_critter.lua

module("modules.configs.excel2json.lua_activity159_critter", package.seeall)

local lua_activity159_critter = {}
local fields = {
	name = 1,
	startPos = 4,
	res = 2,
	anim = 3,
	scale = 5
}
local primaryKey = {
	"name"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity159_critter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity159_critter, "configList", _configList)
	rawset(lua_activity159_critter, "configDict", _configDict)
end

setmetatable(lua_activity159_critter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity159_critter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity159_critter, "configList", nil)
	rawset(lua_activity159_critter, "configDict", nil)
end

return lua_activity159_critter
