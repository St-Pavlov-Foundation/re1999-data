-- chunkname: @modules/configs/excel2json/lua_v3a6_warmup_const.lua

module("modules.configs.excel2json.lua_v3a6_warmup_const", package.seeall)

local lua_v3a6_warmup_const = {}
local fields = {
	id = 1,
	numValue = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v3a6_warmup_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v3a6_warmup_const, "configList", _configList)
	rawset(lua_v3a6_warmup_const, "configDict", _configDict)
end

setmetatable(lua_v3a6_warmup_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v3a6_warmup_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v3a6_warmup_const, "configList", nil)
	rawset(lua_v3a6_warmup_const, "configDict", nil)
end

return lua_v3a6_warmup_const
