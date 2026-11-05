-- chunkname: @modules/configs/excel2json/lua_gpu_level.lua

module("modules.configs.excel2json.lua_gpu_level", package.seeall)

local lua_gpu_level = {}
local fields = {
	level = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.gpu_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_gpu_level, "configList", _configList)
	rawset(lua_gpu_level, "configDict", _configDict)
end

setmetatable(lua_gpu_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_gpu_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_gpu_level, "configList", nil)
	rawset(lua_gpu_level, "configDict", nil)
end

return lua_gpu_level
