-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_level.lua

module("modules.configs.excel2json.lua_v2a4_warmup_level", package.seeall)

local lua_v2a4_warmup_level = {}
local fields = {
	askCount = 2,
	level = 1
}
local primaryKey = {
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_level, "configList", _configList)
	rawset(lua_v2a4_warmup_level, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_level, "configList", nil)
	rawset(lua_v2a4_warmup_level, "configDict", nil)
end

return lua_v2a4_warmup_level
