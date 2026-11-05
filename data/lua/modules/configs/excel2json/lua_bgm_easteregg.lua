-- chunkname: @modules/configs/excel2json/lua_bgm_easteregg.lua

module("modules.configs.excel2json.lua_bgm_easteregg", package.seeall)

local lua_bgm_easteregg = {}
local fields = {
	param1 = 3,
	param2 = 4,
	type = 2,
	id = 1,
	param4 = 6,
	param3 = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.bgm_easteregg_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bgm_easteregg, "configList", _configList)
	rawset(lua_bgm_easteregg, "configDict", _configDict)
end

setmetatable(lua_bgm_easteregg, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bgm_easteregg.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bgm_easteregg, "configList", nil)
	rawset(lua_bgm_easteregg, "configDict", nil)
end

return lua_bgm_easteregg
