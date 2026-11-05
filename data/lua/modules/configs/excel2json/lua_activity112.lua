-- chunkname: @modules/configs/excel2json/lua_activity112.lua

module("modules.configs.excel2json.lua_activity112", package.seeall)

local lua_activity112 = {}
local fields = {
	items = 3,
	theme2 = 12,
	themeDone2 = 14,
	theme = 11,
	themeDone = 13,
	skin = 6,
	skinOffSet = 7,
	chatheadsOffSet = 10,
	head = 5,
	storyId = 15,
	skin2OffSet = 9,
	skin2 = 8,
	id = 2,
	activityId = 1,
	bonus = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	themeDone = 3,
	themeDone2 = 4,
	theme2 = 2,
	theme = 1
}
local _configList, _configDict
local configPath = "configs.activity112_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity112, "configList", _configList)
	rawset(lua_activity112, "configDict", _configDict)
end

setmetatable(lua_activity112, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity112.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity112, "configList", nil)
	rawset(lua_activity112, "configDict", nil)
end

return lua_activity112
