-- chunkname: @modules/configs/excel2json/lua_survival_handbook.lua

module("modules.configs.excel2json.lua_survival_handbook", package.seeall)

local lua_survival_handbook = {}
local fields = {
	subtype = 3,
	name = 4,
	roleId = 8,
	type = 2,
	id = 1,
	eventId = 7,
	link = 5,
	desc = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_handbook_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_handbook, "configList", _configList)
	rawset(lua_survival_handbook, "configDict", _configDict)
end

setmetatable(lua_survival_handbook, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_handbook.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_handbook, "configList", nil)
	rawset(lua_survival_handbook, "configDict", nil)
end

return lua_survival_handbook
