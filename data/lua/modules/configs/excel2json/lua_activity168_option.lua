-- chunkname: @modules/configs/excel2json/lua_activity168_option.lua

module("modules.configs.excel2json.lua_activity168_option", package.seeall)

local lua_activity168_option = {}
local fields = {
	activityId = 1,
	name = 3,
	costItems = 6,
	effectId = 5,
	mustDrop = 7,
	optionId = 2,
	desc = 4
}
local primaryKey = {
	"activityId",
	"optionId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity168_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity168_option, "configList", _configList)
	rawset(lua_activity168_option, "configDict", _configDict)
end

setmetatable(lua_activity168_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity168_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity168_option, "configList", nil)
	rawset(lua_activity168_option, "configDict", nil)
end

return lua_activity168_option
