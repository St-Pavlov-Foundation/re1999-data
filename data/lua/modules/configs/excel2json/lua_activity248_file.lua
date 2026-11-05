-- chunkname: @modules/configs/excel2json/lua_activity248_file.lua

module("modules.configs.excel2json.lua_activity248_file", package.seeall)

local lua_activity248_file = {}
local fields = {
	param = 3,
	name = 11,
	complete = 10,
	type = 2,
	tip = 7,
	previous = 4,
	desc = 12,
	unlock = 9,
	portrait = 13,
	slotIds = 5,
	id = 1,
	lock = 8,
	reportId = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tip = 1,
	name = 2,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.activity248_file_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity248_file, "configList", _configList)
	rawset(lua_activity248_file, "configDict", _configDict)
end

setmetatable(lua_activity248_file, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity248_file.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity248_file, "configList", nil)
	rawset(lua_activity248_file, "configDict", nil)
end

return lua_activity248_file
