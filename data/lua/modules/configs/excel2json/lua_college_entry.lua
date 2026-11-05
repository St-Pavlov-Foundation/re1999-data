-- chunkname: @modules/configs/excel2json/lua_college_entry.lua

module("modules.configs.excel2json.lua_college_entry", package.seeall)

local lua_college_entry = {}
local fields = {
	id = 1,
	quality = 2,
	description = 4,
	tags = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	description = 1
}
local _configList, _configDict
local configPath = "configs.college_entry_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_entry, "configList", _configList)
	rawset(lua_college_entry, "configDict", _configDict)
end

setmetatable(lua_college_entry, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_entry.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_entry, "configList", nil)
	rawset(lua_college_entry, "configDict", nil)
end

return lua_college_entry
