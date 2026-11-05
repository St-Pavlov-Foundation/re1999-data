-- chunkname: @modules/configs/excel2json/lua_messagebox.lua

module("modules.configs.excel2json.lua_messagebox", package.seeall)

local lua_messagebox = {}
local fields = {
	id = 1,
	title = 3,
	content = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 1,
	title = 2
}
local _configList, _configDict
local configPath = "configs.messagebox_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_messagebox, "configList", _configList)
	rawset(lua_messagebox, "configDict", _configDict)
end

setmetatable(lua_messagebox, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_messagebox.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_messagebox, "configList", nil)
	rawset(lua_messagebox, "configDict", nil)
end

return lua_messagebox
