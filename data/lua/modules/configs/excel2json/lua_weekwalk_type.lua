-- chunkname: @modules/configs/excel2json/lua_weekwalk_type.lua

module("modules.configs.excel2json.lua_weekwalk_type", package.seeall)

local lua_weekwalk_type = {}
local fields = {
	heroCd = 2,
	isRefresh = 5,
	starNum = 7,
	type = 1,
	showDetail = 6,
	canResetLayer = 4,
	star = 3
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_type, "configList", _configList)
	rawset(lua_weekwalk_type, "configDict", _configDict)
end

setmetatable(lua_weekwalk_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_type, "configList", nil)
	rawset(lua_weekwalk_type, "configDict", nil)
end

return lua_weekwalk_type
