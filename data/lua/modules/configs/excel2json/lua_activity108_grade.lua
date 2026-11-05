-- chunkname: @modules/configs/excel2json/lua_activity108_grade.lua

module("modules.configs.excel2json.lua_activity108_grade", package.seeall)

local lua_activity108_grade = {}
local fields = {
	score = 3,
	mapId = 2,
	bonus = 5,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity108_grade_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity108_grade, "configList", _configList)
	rawset(lua_activity108_grade, "configDict", _configDict)
end

setmetatable(lua_activity108_grade, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity108_grade.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity108_grade, "configList", nil)
	rawset(lua_activity108_grade, "configDict", nil)
end

return lua_activity108_grade
