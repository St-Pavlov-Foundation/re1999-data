-- chunkname: @modules/configs/excel2json/lua_weekwalk_pray.lua

module("modules.configs.excel2json.lua_weekwalk_pray", package.seeall)

local lua_weekwalk_pray = {}
local fields = {
	sacrificeLimit = 2,
	effect = 4,
	blessingLimit = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_pray_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_pray, "configList", _configList)
	rawset(lua_weekwalk_pray, "configDict", _configDict)
end

setmetatable(lua_weekwalk_pray, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_pray.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_pray, "configList", nil)
	rawset(lua_weekwalk_pray, "configDict", nil)
end

return lua_weekwalk_pray
