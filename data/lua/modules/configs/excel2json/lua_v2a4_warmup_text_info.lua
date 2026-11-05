-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_text_info.lua

module("modules.configs.excel2json.lua_v2a4_warmup_text_info", package.seeall)

local lua_v2a4_warmup_text_info = {}
local fields = {
	id = 1,
	name = 2,
	value = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	value = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_text_info_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_text_info, "configList", _configList)
	rawset(lua_v2a4_warmup_text_info, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_text_info, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_text_info.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_text_info, "configList", nil)
	rawset(lua_v2a4_warmup_text_info, "configDict", nil)
end

return lua_v2a4_warmup_text_info
