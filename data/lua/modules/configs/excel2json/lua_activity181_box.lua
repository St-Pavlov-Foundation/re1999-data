-- chunkname: @modules/configs/excel2json/lua_activity181_box.lua

module("modules.configs.excel2json.lua_activity181_box", package.seeall)

local lua_activity181_box = {}
local fields = {
	showOnlineTime = 2,
	bonus = 5,
	obtainStart = 7,
	obtainTimes = 9,
	showOfflineTime = 3,
	obtainType = 6,
	totalBox = 4,
	activityId = 1,
	obtainEnd = 8
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity181_box_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity181_box, "configList", _configList)
	rawset(lua_activity181_box, "configDict", _configDict)
end

setmetatable(lua_activity181_box, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity181_box.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity181_box, "configList", nil)
	rawset(lua_activity181_box, "configDict", nil)
end

return lua_activity181_box
