-- chunkname: @modules/configs/excel2json/lua_activity142_tips.lua

module("modules.configs.excel2json.lua_activity142_tips", package.seeall)

local lua_activity142_tips = {}
local fields = {
	id = 2,
	tips = 3,
	activityId = 1,
	audioId = 4
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity142_tips_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity142_tips, "configList", _configList)
	rawset(lua_activity142_tips, "configDict", _configDict)
end

setmetatable(lua_activity142_tips, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity142_tips.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity142_tips, "configList", nil)
	rawset(lua_activity142_tips, "configDict", nil)
end

return lua_activity142_tips
