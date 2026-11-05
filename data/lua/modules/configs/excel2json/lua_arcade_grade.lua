-- chunkname: @modules/configs/excel2json/lua_arcade_grade.lua

module("modules.configs.excel2json.lua_arcade_grade", package.seeall)

local lua_arcade_grade = {}
local fields = {
	gainRateAdd = 3,
	icon = 2,
	needScore = 1
}
local primaryKey = {
	"needScore"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_grade_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_grade, "configList", _configList)
	rawset(lua_arcade_grade, "configDict", _configDict)
end

setmetatable(lua_arcade_grade, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_grade.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_grade, "configList", nil)
	rawset(lua_arcade_grade, "configDict", nil)
end

return lua_arcade_grade
