-- chunkname: @modules/configs/excel2json/lua_activity128_bosstype.lua

module("modules.configs.excel2json.lua_activity128_bosstype", package.seeall)

local lua_activity128_bosstype = {}
local fields = {
	mintype = 1,
	name = 3,
	sort = 2
}
local primaryKey = {
	"mintype"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity128_bosstype_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_bosstype, "configList", _configList)
	rawset(lua_activity128_bosstype, "configDict", _configDict)
end

setmetatable(lua_activity128_bosstype, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_bosstype.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_bosstype, "configList", nil)
	rawset(lua_activity128_bosstype, "configDict", nil)
end

return lua_activity128_bosstype
