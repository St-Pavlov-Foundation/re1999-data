-- chunkname: @modules/configs/excel2json/lua_reddot.lua

module("modules.configs.excel2json.lua_reddot", package.seeall)

local lua_reddot = {}
local fields = {
	canLoad = 4,
	isOnline = 3,
	parent = 2,
	style = 5,
	id = 1,
	isChangeUi = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.reddot_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_reddot, "configList", _configList)
	rawset(lua_reddot, "configDict", _configDict)
end

setmetatable(lua_reddot, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_reddot.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_reddot, "configList", nil)
	rawset(lua_reddot, "configDict", nil)
end

return lua_reddot
