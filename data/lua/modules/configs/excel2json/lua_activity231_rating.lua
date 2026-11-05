-- chunkname: @modules/configs/excel2json/lua_activity231_rating.lua

module("modules.configs.excel2json.lua_activity231_rating", package.seeall)

local lua_activity231_rating = {}
local fields = {
	id = 2,
	rating = 3,
	activityId = 1,
	icon = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity231_rating_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_rating, "configList", _configList)
	rawset(lua_activity231_rating, "configDict", _configDict)
end

setmetatable(lua_activity231_rating, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_rating.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_rating, "configList", nil)
	rawset(lua_activity231_rating, "configDict", nil)
end

return lua_activity231_rating
