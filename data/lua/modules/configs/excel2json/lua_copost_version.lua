-- chunkname: @modules/configs/excel2json/lua_copost_version.lua

module("modules.configs.excel2json.lua_copost_version", package.seeall)

local lua_copost_version = {}
local fields = {
	id = 2,
	timeId = 3,
	versionId = 1
}
local primaryKey = {
	"versionId"
}
local mlStringKey = {
	timeId = 1
}
local _configList, _configDict
local configPath = "configs.copost_version_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_version, "configList", _configList)
	rawset(lua_copost_version, "configDict", _configDict)
end

setmetatable(lua_copost_version, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_version.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_version, "configList", nil)
	rawset(lua_copost_version, "configDict", nil)
end

return lua_copost_version
