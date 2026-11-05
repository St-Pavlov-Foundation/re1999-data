-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_dialog_style.lua

module("modules.configs.excel2json.lua_v2a4_warmup_dialog_style", package.seeall)

local lua_v2a4_warmup_dialog_style = {}
local fields = {
	id = 1,
	fontColor = 3,
	className = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_dialog_style_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_dialog_style, "configList", _configList)
	rawset(lua_v2a4_warmup_dialog_style, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_dialog_style, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_dialog_style.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_dialog_style, "configList", nil)
	rawset(lua_v2a4_warmup_dialog_style, "configDict", nil)
end

return lua_v2a4_warmup_dialog_style
