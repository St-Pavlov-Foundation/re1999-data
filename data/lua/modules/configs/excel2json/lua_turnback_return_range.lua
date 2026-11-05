-- chunkname: @modules/configs/excel2json/lua_turnback_return_range.lua

module("modules.configs.excel2json.lua_turnback_return_range", package.seeall)

local lua_turnback_return_range = {}
local fields = {
	lossDays = 2,
	rangeId = 1
}
local primaryKey = {
	"rangeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_return_range_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_return_range, "configList", _configList)
	rawset(lua_turnback_return_range, "configDict", _configDict)
end

setmetatable(lua_turnback_return_range, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_return_range.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_return_range, "configList", nil)
	rawset(lua_turnback_return_range, "configDict", nil)
end

return lua_turnback_return_range
