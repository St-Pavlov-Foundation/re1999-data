-- chunkname: @modules/configs/excel2json/lua_copost_time_axis.lua

module("modules.configs.excel2json.lua_copost_time_axis", package.seeall)

local lua_copost_time_axis = {}
local fields = {
	id = 2,
	timeId = 3,
	sceneId = 4,
	versionId = 1
}
local primaryKey = {
	"versionId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.copost_time_axis_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_time_axis, "configList", _configList)
	rawset(lua_copost_time_axis, "configDict", _configDict)
end

setmetatable(lua_copost_time_axis, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_time_axis.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_time_axis, "configList", nil)
	rawset(lua_copost_time_axis, "configDict", nil)
end

return lua_copost_time_axis
