-- chunkname: @modules/configs/excel2json/lua_activity208.lua

module("modules.configs.excel2json.lua_activity208", package.seeall)

local lua_activity208 = {}
local fields = {
	id = 2,
	isAllBonus = 3,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity208_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity208, "configList", _configList)
	rawset(lua_activity208, "configDict", _configDict)
end

setmetatable(lua_activity208, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity208.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity208, "configList", nil)
	rawset(lua_activity208, "configDict", nil)
end

return lua_activity208
