-- chunkname: @modules/configs/excel2json/lua_friendless.lua

module("modules.configs.excel2json.lua_friendless", package.seeall)

local lua_friendless = {}
local fields = {
	friendliness = 2,
	percentage = 1
}
local primaryKey = {
	"percentage"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.friendless_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_friendless, "configList", _configList)
	rawset(lua_friendless, "configDict", _configDict)
end

setmetatable(lua_friendless, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_friendless.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_friendless, "configList", nil)
	rawset(lua_friendless, "configDict", nil)
end

return lua_friendless
