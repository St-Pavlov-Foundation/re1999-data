-- chunkname: @modules/configs/excel2json/lua_weekwalk_handbook.lua

module("modules.configs.excel2json.lua_weekwalk_handbook", package.seeall)

local lua_weekwalk_handbook = {}
local fields = {
	text = 6,
	positionOffset = 5,
	type = 3,
	id = 1,
	position = 4,
	branchId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_handbook_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_handbook, "configList", _configList)
	rawset(lua_weekwalk_handbook, "configDict", _configDict)
end

setmetatable(lua_weekwalk_handbook, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_handbook.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_handbook, "configList", nil)
	rawset(lua_weekwalk_handbook, "configDict", nil)
end

return lua_weekwalk_handbook
