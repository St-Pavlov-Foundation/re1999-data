-- chunkname: @modules/configs/excel2json/lua_activity104_retail_new.lua

module("modules.configs.excel2json.lua_activity104_retail_new", package.seeall)

local lua_activity104_retail_new = {}
local fields = {
	level = 4,
	equipRareWeight = 5,
	retailEpisodeId = 2,
	activityId = 1,
	desc = 3
}
local primaryKey = {
	"activityId",
	"retailEpisodeId"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity104_retail_new_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_retail_new, "configList", _configList)
	rawset(lua_activity104_retail_new, "configDict", _configDict)
end

setmetatable(lua_activity104_retail_new, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_retail_new.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_retail_new, "configList", nil)
	rawset(lua_activity104_retail_new, "configDict", nil)
end

return lua_activity104_retail_new
