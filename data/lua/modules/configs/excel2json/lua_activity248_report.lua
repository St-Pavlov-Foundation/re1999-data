-- chunkname: @modules/configs/excel2json/lua_activity248_report.lua

module("modules.configs.excel2json.lua_activity248_report", package.seeall)

local lua_activity248_report = {}
local fields = {
	id = 1,
	answers = 5,
	optionIds = 4,
	title = 2,
	content = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity248_report_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity248_report, "configList", _configList)
	rawset(lua_activity248_report, "configDict", _configDict)
end

setmetatable(lua_activity248_report, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity248_report.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity248_report, "configList", nil)
	rawset(lua_activity248_report, "configDict", nil)
end

return lua_activity248_report
