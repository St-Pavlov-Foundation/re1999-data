-- chunkname: @modules/configs/excel2json/lua_activity_decoration.lua

module("modules.configs.excel2json.lua_activity_decoration", package.seeall)

local lua_activity_decoration = {}
local fields = {
	id = 1,
	chargeRes = 2,
	chargeUIRes = 4,
	millisecond = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity_decoration_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity_decoration, "configList", _configList)
	rawset(lua_activity_decoration, "configDict", _configDict)
end

setmetatable(lua_activity_decoration, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity_decoration.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity_decoration, "configList", nil)
	rawset(lua_activity_decoration, "configDict", nil)
end

return lua_activity_decoration
