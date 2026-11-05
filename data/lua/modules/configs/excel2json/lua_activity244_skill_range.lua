-- chunkname: @modules/configs/excel2json/lua_activity244_skill_range.lua

module("modules.configs.excel2json.lua_activity244_skill_range", package.seeall)

local lua_activity244_skill_range = {}
local fields = {
	id = 1,
	range = 2,
	rangeType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_skill_range_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_skill_range, "configList", _configList)
	rawset(lua_activity244_skill_range, "configDict", _configDict)
end

setmetatable(lua_activity244_skill_range, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_skill_range.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_skill_range, "configList", nil)
	rawset(lua_activity244_skill_range, "configDict", nil)
end

return lua_activity244_skill_range
