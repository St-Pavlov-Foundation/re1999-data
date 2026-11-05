-- chunkname: @modules/configs/excel2json/lua_activity123_retail.lua

module("modules.configs.excel2json.lua_activity123_retail", package.seeall)

local lua_activity123_retail = {}
local fields = {
	desc = 4,
	bonus = 5,
	id = 2,
	activityId = 1,
	episodeId = 3
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity123_retail_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity123_retail, "configList", _configList)
	rawset(lua_activity123_retail, "configDict", _configDict)
end

setmetatable(lua_activity123_retail, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity123_retail.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity123_retail, "configList", nil)
	rawset(lua_activity123_retail, "configDict", nil)
end

return lua_activity123_retail
