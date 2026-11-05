-- chunkname: @modules/configs/excel2json/lua_recycle_conversion.lua

module("modules.configs.excel2json.lua_recycle_conversion", package.seeall)

local lua_recycle_conversion = {}
local fields = {
	recycleId = 1,
	recycleType = 2,
	conversionId = 3,
	conversionType = 4
}
local primaryKey = {
	"recycleId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.recycle_conversion_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_recycle_conversion, "configList", _configList)
	rawset(lua_recycle_conversion, "configDict", _configDict)
end

setmetatable(lua_recycle_conversion, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_recycle_conversion.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_recycle_conversion, "configList", nil)
	rawset(lua_recycle_conversion, "configDict", nil)
end

return lua_recycle_conversion
