-- chunkname: @modules/configs/excel2json/lua_activity128_assess.lua

module("modules.configs.excel2json.lua_activity128_assess", package.seeall)

local lua_activity128_assess = {}
local fields = {
	spriteName = 3,
	needPointBoss1 = 4,
	mainBg = 8,
	needPointBoss2 = 5,
	layer4Assess = 9,
	battleIconBg = 7,
	strLevel = 2,
	needPointBoss3 = 6,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity128_assess_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_assess, "configList", _configList)
	rawset(lua_activity128_assess, "configDict", _configDict)
end

setmetatable(lua_activity128_assess, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_assess.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_assess, "configList", nil)
	rawset(lua_activity128_assess, "configDict", nil)
end

return lua_activity128_assess
