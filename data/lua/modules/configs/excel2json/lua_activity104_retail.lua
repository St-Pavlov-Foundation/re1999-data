-- chunkname: @modules/configs/excel2json/lua_activity104_retail.lua

module("modules.configs.excel2json.lua_activity104_retail", package.seeall)

local lua_activity104_retail = {}
local fields = {
	retailEpisodeIdPool = 3,
	equipRareWeight = 6,
	activityId = 1,
	stage = 2,
	enemyTag = 4,
	level = 5
}
local primaryKey = {
	"activityId",
	"stage"
}
local mlStringKey = {
	enemyTag = 1
}
local _configList, _configDict
local configPath = "configs.activity104_retail_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity104_retail, "configList", _configList)
	rawset(lua_activity104_retail, "configDict", _configDict)
end

setmetatable(lua_activity104_retail, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity104_retail.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity104_retail, "configList", nil)
	rawset(lua_activity104_retail, "configDict", nil)
end

return lua_activity104_retail
