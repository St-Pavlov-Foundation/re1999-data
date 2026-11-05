-- chunkname: @modules/configs/excel2json/lua_atomic_library.lua

module("modules.configs.excel2json.lua_atomic_library", package.seeall)

local lua_atomic_library = {}
local fields = {
	unlockTips = 7,
	res = 5,
	type = 4,
	id = 1,
	title = 2,
	content = 3,
	detail = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	unlockTips = 3,
	title = 1,
	content = 2
}
local _configList, _configDict
local configPath = "configs.atomic_library_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_library, "configList", _configList)
	rawset(lua_atomic_library, "configDict", _configDict)
end

setmetatable(lua_atomic_library, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_library.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_library, "configList", nil)
	rawset(lua_atomic_library, "configDict", nil)
end

return lua_atomic_library
