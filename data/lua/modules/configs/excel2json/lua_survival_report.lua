-- chunkname: @modules/configs/excel2json/lua_survival_report.lua

module("modules.configs.excel2json.lua_survival_report", package.seeall)

local lua_survival_report = {}
local fields = {
	priority = 4,
	img = 5,
	type = 2,
	id = 1,
	condition = 3,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_report_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_report, "configList", _configList)
	rawset(lua_survival_report, "configDict", _configDict)
end

setmetatable(lua_survival_report, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_report.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_report, "configList", nil)
	rawset(lua_survival_report, "configDict", nil)
end

return lua_survival_report
