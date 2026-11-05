-- chunkname: @modules/configs/excel2json/lua_activity181_boxlist.lua

module("modules.configs.excel2json.lua_activity181_boxlist", package.seeall)

local lua_activity181_boxlist = {}
local fields = {
	id = 2,
	bonusWeight = 4,
	activityId = 1,
	bonus = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity181_boxlist_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity181_boxlist, "configList", _configList)
	rawset(lua_activity181_boxlist, "configDict", _configDict)
end

setmetatable(lua_activity181_boxlist, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity181_boxlist.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity181_boxlist, "configList", nil)
	rawset(lua_activity181_boxlist, "configDict", nil)
end

return lua_activity181_boxlist
