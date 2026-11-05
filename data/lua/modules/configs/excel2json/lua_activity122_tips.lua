-- chunkname: @modules/configs/excel2json/lua_activity122_tips.lua

module("modules.configs.excel2json.lua_activity122_tips", package.seeall)

local lua_activity122_tips = {}
local fields = {
	id = 2,
	content = 3,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity122_tips_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity122_tips, "configList", _configList)
	rawset(lua_activity122_tips, "configDict", _configDict)
end

setmetatable(lua_activity122_tips, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity122_tips.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity122_tips, "configList", nil)
	rawset(lua_activity122_tips, "configDict", nil)
end

return lua_activity122_tips
