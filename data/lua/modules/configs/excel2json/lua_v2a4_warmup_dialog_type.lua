-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_dialog_type.lua

module("modules.configs.excel2json.lua_v2a4_warmup_dialog_type", package.seeall)

local lua_v2a4_warmup_dialog_type = {}
local fields = {
	id = 1,
	style = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_dialog_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_dialog_type, "configList", _configList)
	rawset(lua_v2a4_warmup_dialog_type, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_dialog_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_dialog_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_dialog_type, "configList", nil)
	rawset(lua_v2a4_warmup_dialog_type, "configDict", nil)
end

return lua_v2a4_warmup_dialog_type
