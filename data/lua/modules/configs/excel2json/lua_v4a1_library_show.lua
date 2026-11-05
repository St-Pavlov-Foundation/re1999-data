-- chunkname: @modules/configs/excel2json/lua_v4a1_library_show.lua

module("modules.configs.excel2json.lua_v4a1_library_show", package.seeall)

local lua_v4a1_library_show = {}
local fields = {
	charIds = 2,
	days = 1
}
local primaryKey = {
	"days"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.v4a1_library_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_v4a1_library_show, "configList", _configList)
	rawset(lua_v4a1_library_show, "configDict", _configDict)
end

setmetatable(lua_v4a1_library_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_v4a1_library_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_v4a1_library_show, "configList", nil)
	rawset(lua_v4a1_library_show, "configDict", nil)
end

return lua_v4a1_library_show
