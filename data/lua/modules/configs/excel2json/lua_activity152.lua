-- chunkname: @modules/configs/excel2json/lua_activity152.lua

module("modules.configs.excel2json.lua_activity152", package.seeall)

local lua_activity152 = {}
local fields = {
	presentName = 3,
	presentId = 2,
	roleNameEn = 8,
	presentIcon = 4,
	bonus = 10,
	acceptDate = 11,
	roleName = 7,
	roleIcon = 6,
	dialog = 9,
	activityId = 1,
	presentSign = 5
}
local primaryKey = {
	"activityId",
	"presentId"
}
local mlStringKey = {
	roleName = 2,
	presentName = 1,
	dialog = 3
}
local _configList, _configDict
local configPath = "configs.activity152_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity152, "configList", _configList)
	rawset(lua_activity152, "configDict", _configDict)
end

setmetatable(lua_activity152, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity152.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity152, "configList", nil)
	rawset(lua_activity152, "configDict", nil)
end

return lua_activity152
