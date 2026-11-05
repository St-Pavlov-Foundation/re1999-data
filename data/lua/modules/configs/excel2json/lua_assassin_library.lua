-- chunkname: @modules/configs/excel2json/lua_assassin_library.lua

module("modules.configs.excel2json.lua_assassin_library", package.seeall)

local lua_assassin_library = {}
local fields = {
	toastIcon = 7,
	storyId = 11,
	type = 5,
	title = 2,
	content = 3,
	unlock = 9,
	res = 6,
	talk = 10,
	id = 1,
	activityId = 4,
	detail = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.assassin_library_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_library, "configList", _configList)
	rawset(lua_assassin_library, "configDict", _configDict)
end

setmetatable(lua_assassin_library, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_library.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_library, "configList", nil)
	rawset(lua_assassin_library, "configDict", nil)
end

return lua_assassin_library
