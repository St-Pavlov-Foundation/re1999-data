-- chunkname: @modules/configs/excel2json/lua_activity154_options.lua

module("modules.configs.excel2json.lua_activity154_options", package.seeall)

local lua_activity154_options = {}
local fields = {
	optionText = 3,
	optionId = 2,
	puzzleId = 1
}
local primaryKey = {
	"puzzleId",
	"optionId"
}
local mlStringKey = {
	optionText = 1
}
local _configList, _configDict
local configPath = "configs.activity154_options_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity154_options, "configList", _configList)
	rawset(lua_activity154_options, "configDict", _configDict)
end

setmetatable(lua_activity154_options, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity154_options.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity154_options, "configList", nil)
	rawset(lua_activity154_options, "configDict", nil)
end

return lua_activity154_options
