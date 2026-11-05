-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_const_mlstring.lua

module("modules.configs.excel2json.lua_v2a4_warmup_const_mlstring", package.seeall)

local lua_v2a4_warmup_const_mlstring = {}
local fields = {
	id = 1,
	value = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 1
}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_const_mlstring_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_const_mlstring, "configList", _configList)
	rawset(lua_v2a4_warmup_const_mlstring, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_const_mlstring, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_const_mlstring.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_const_mlstring, "configList", nil)
	rawset(lua_v2a4_warmup_const_mlstring, "configDict", nil)
end

return lua_v2a4_warmup_const_mlstring
