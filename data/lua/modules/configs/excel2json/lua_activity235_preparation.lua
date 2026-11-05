-- chunkname: @modules/configs/excel2json/lua_activity235_preparation.lua

module("modules.configs.excel2json.lua_activity235_preparation", package.seeall)

local lua_activity235_preparation = {}
local fields = {
	buffdesc = 4,
	name = 2,
	unlockpara = 9,
	unlockdesc = 7,
	material = 3,
	buffpara = 6,
	buffcond = 5,
	id = 1,
	unlockcond = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	buffdesc = 1,
	unlockdesc = 2
}
local _configList, _configDict
local configPath = "configs.activity235_preparation_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity235_preparation, "configList", _configList)
	rawset(lua_activity235_preparation, "configDict", _configDict)
end

setmetatable(lua_activity235_preparation, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity235_preparation.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity235_preparation, "configList", nil)
	rawset(lua_activity235_preparation, "configDict", nil)
end

return lua_activity235_preparation
