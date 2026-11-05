-- chunkname: @modules/configs/excel2json/lua_bgm_type.lua

module("modules.configs.excel2json.lua_bgm_type", package.seeall)

local lua_bgm_type = {}
local fields = {
	id = 1,
	typename = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	typename = 1
}
local _configList, _configDict
local configPath = "configs.bgm_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bgm_type, "configList", _configList)
	rawset(lua_bgm_type, "configDict", _configDict)
end

setmetatable(lua_bgm_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bgm_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bgm_type, "configList", nil)
	rawset(lua_bgm_type, "configDict", nil)
end

return lua_bgm_type
