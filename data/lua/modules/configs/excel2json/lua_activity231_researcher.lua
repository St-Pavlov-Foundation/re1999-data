-- chunkname: @modules/configs/excel2json/lua_activity231_researcher.lua

module("modules.configs.excel2json.lua_activity231_researcher", package.seeall)

local lua_activity231_researcher = {}
local fields = {
	cost = 9,
	name = 5,
	settleTimes = 11,
	quality = 3,
	skillIds = 12,
	unlockCondition = 4,
	image2 = 8,
	image1 = 7,
	id = 2,
	icon = 6,
	activityId = 1,
	attribute = 10
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity231_researcher_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_researcher, "configList", _configList)
	rawset(lua_activity231_researcher, "configDict", _configDict)
end

setmetatable(lua_activity231_researcher, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_researcher.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_researcher, "configList", nil)
	rawset(lua_activity231_researcher, "configDict", nil)
end

return lua_activity231_researcher
