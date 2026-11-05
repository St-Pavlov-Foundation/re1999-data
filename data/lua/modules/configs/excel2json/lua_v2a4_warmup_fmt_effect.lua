-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_fmt_effect.lua

module("modules.configs.excel2json.lua_v2a4_warmup_fmt_effect", package.seeall)

local lua_v2a4_warmup_fmt_effect = {}
local fields = {
	id = 1,
	args = 3,
	handler = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_fmt_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_fmt_effect, "configList", _configList)
	rawset(lua_v2a4_warmup_fmt_effect, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_fmt_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_fmt_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_fmt_effect, "configList", nil)
	rawset(lua_v2a4_warmup_fmt_effect, "configDict", nil)
end

return lua_v2a4_warmup_fmt_effect
