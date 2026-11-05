-- chunkname: @modules/configs/excel2json/lua_v3a2_chapter_report.lua

module("modules.configs.excel2json.lua_v3a2_chapter_report", package.seeall)

local lua_v3a2_chapter_report = {}
local fields = {
	id = 1,
	res = 3,
	element = 2,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.v3a2_chapter_report_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a2_chapter_report, "configList", _configList)
	rawset(lua_v3a2_chapter_report, "configDict", _configDict)
end

setmetatable(lua_v3a2_chapter_report, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a2_chapter_report.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a2_chapter_report, "configList", nil)
	rawset(lua_v3a2_chapter_report, "configDict", nil)
end

return lua_v3a2_chapter_report
