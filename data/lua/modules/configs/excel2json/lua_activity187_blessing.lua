-- chunkname: @modules/configs/excel2json/lua_activity187_blessing.lua

module("modules.configs.excel2json.lua_activity187_blessing", package.seeall)

local lua_activity187_blessing = {}
local fields = {
	lanternImg = 5,
	lanternImgBg = 6,
	blessing = 7,
	lanternRibbon = 4,
	lantern = 3,
	activityId = 1,
	bonus = 2
}
local primaryKey = {
	"activityId",
	"bonus"
}
local mlStringKey = {
	blessing = 1
}
local _configList, _configDict
local configPath = "configs.activity187_blessing_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity187_blessing, "configList", _configList)
	rawset(lua_activity187_blessing, "configDict", _configDict)
end

setmetatable(lua_activity187_blessing, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity187_blessing.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity187_blessing, "configList", nil)
	rawset(lua_activity187_blessing, "configDict", nil)
end

return lua_activity187_blessing
