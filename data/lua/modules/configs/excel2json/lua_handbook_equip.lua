-- chunkname: @modules/configs/excel2json/lua_handbook_equip.lua

module("modules.configs.excel2json.lua_handbook_equip", package.seeall)

local lua_handbook_equip = {}
local fields = {
	id = 1,
	equipId = 3,
	desc = 4,
	order = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.handbook_equip_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_handbook_equip, "configList", _configList)
	rawset(lua_handbook_equip, "configDict", _configDict)
end

setmetatable(lua_handbook_equip, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_handbook_equip.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_handbook_equip, "configList", nil)
	rawset(lua_handbook_equip, "configDict", nil)
end

return lua_handbook_equip
