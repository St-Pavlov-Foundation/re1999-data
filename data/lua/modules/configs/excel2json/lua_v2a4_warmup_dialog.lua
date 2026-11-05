-- chunkname: @modules/configs/excel2json/lua_v2a4_warmup_dialog.lua

module("modules.configs.excel2json.lua_v2a4_warmup_dialog", package.seeall)

local lua_v2a4_warmup_dialog = {}
local fields = {
	fmt1 = 5,
	fmt3 = 7,
	fmt2 = 6,
	nextId = 4,
	group = 2,
	desc = 3,
	id = 1,
	fmt5 = 9,
	fmt4 = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.v2a4_warmup_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v2a4_warmup_dialog, "configList", _configList)
	rawset(lua_v2a4_warmup_dialog, "configDict", _configDict)
end

setmetatable(lua_v2a4_warmup_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v2a4_warmup_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v2a4_warmup_dialog, "configList", nil)
	rawset(lua_v2a4_warmup_dialog, "configDict", nil)
end

return lua_v2a4_warmup_dialog
