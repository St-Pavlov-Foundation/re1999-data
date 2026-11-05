-- chunkname: @modules/configs/excel2json/lua_activity147.lua

module("modules.configs.excel2json.lua_activity147", package.seeall)

local lua_activity147 = {}
local fields = {
	jumpId = 6,
	descList = 2,
	spineRes = 4,
	rewardList = 3,
	dialogs = 5,
	activityId = 1
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {
	descList = 1,
	dialogs = 2
}
local _configList, _configDict
local configPath = "configs.activity147_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity147, "configList", _configList)
	rawset(lua_activity147, "configDict", _configDict)
end

setmetatable(lua_activity147, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity147.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity147, "configList", nil)
	rawset(lua_activity147, "configDict", nil)
end

return lua_activity147
