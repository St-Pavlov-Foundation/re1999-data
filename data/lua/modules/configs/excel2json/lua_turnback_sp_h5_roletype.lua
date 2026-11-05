-- chunkname: @modules/configs/excel2json/lua_turnback_sp_h5_roletype.lua

module("modules.configs.excel2json.lua_turnback_sp_h5_roletype", package.seeall)

local lua_turnback_sp_h5_roletype = {}
local fields = {
	id = 1,
	name = 2,
	nameHexColor = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.turnback_sp_h5_roletype_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_sp_h5_roletype, "configList", _configList)
	rawset(lua_turnback_sp_h5_roletype, "configDict", _configDict)
end

setmetatable(lua_turnback_sp_h5_roletype, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_sp_h5_roletype.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_sp_h5_roletype, "configList", nil)
	rawset(lua_turnback_sp_h5_roletype, "configDict", nil)
end

return lua_turnback_sp_h5_roletype
