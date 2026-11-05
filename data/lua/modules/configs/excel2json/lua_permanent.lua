-- chunkname: @modules/configs/excel2json/lua_permanent.lua

module("modules.configs.excel2json.lua_permanent", package.seeall)

local lua_permanent = {}
local fields = {
	id = 1,
	enterview = 3,
	kvIcon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.permanent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_permanent, "configList", _configList)
	rawset(lua_permanent, "configDict", _configDict)
end

setmetatable(lua_permanent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_permanent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_permanent, "configList", nil)
	rawset(lua_permanent, "configDict", nil)
end

return lua_permanent
