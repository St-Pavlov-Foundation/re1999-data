-- chunkname: @modules/configs/excel2json/lua_activity226_box.lua

module("modules.configs.excel2json.lua_activity226_box", package.seeall)

local lua_activity226_box = {}
local fields = {
	oneBoxNum = 5,
	bonus = 6,
	showOnlineTime = 2,
	totalBox = 4,
	activityId = 1,
	showOfflineTime = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity226_box_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity226_box, "configList", _configList)
	rawset(lua_activity226_box, "configDict", _configDict)
end

setmetatable(lua_activity226_box, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity226_box.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity226_box, "configList", nil)
	rawset(lua_activity226_box, "configDict", nil)
end

return lua_activity226_box
