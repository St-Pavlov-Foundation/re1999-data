-- chunkname: @modules/configs/excel2json/lua_activity132_collect.lua

module("modules.configs.excel2json.lua_activity132_collect", package.seeall)

local lua_activity132_collect = {}
local fields = {
	nameEn = 6,
	name = 3,
	collectId = 2,
	bg = 4,
	activityId = 1,
	clues = 5
}
local primaryKey = {
	"activityId",
	"collectId"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity132_collect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity132_collect, "configList", _configList)
	rawset(lua_activity132_collect, "configDict", _configDict)
end

setmetatable(lua_activity132_collect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity132_collect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity132_collect, "configList", nil)
	rawset(lua_activity132_collect, "configDict", nil)
end

return lua_activity132_collect
