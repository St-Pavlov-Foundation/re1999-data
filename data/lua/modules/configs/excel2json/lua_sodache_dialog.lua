-- chunkname: @modules/configs/excel2json/lua_sodache_dialog.lua

module("modules.configs.excel2json.lua_sodache_dialog", package.seeall)

local lua_sodache_dialog = {}
local fields = {
	actor = 5,
	group = 2,
	head = 6,
	desc = 7,
	id = 1,
	position = 4,
	order = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	actor = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.sodache_dialog_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_dialog, "configList", _configList)
	rawset(lua_sodache_dialog, "configDict", _configDict)
end

setmetatable(lua_sodache_dialog, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_dialog.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_dialog, "configList", nil)
	rawset(lua_sodache_dialog, "configDict", nil)
end

return lua_sodache_dialog
