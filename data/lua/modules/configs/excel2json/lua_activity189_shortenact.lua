-- chunkname: @modules/configs/excel2json/lua_activity189_shortenact.lua

module("modules.configs.excel2json.lua_activity189_shortenact", package.seeall)

local lua_activity189_shortenact = {}
local fields = {
	id = 1,
	version = 2,
	style = 4,
	settingId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity189_shortenact_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity189_shortenact, "configList", _configList)
	rawset(lua_activity189_shortenact, "configDict", _configDict)
end

setmetatable(lua_activity189_shortenact, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity189_shortenact.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity189_shortenact, "configList", nil)
	rawset(lua_activity189_shortenact, "configDict", nil)
end

return lua_activity189_shortenact
