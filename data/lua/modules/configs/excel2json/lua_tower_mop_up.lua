-- chunkname: @modules/configs/excel2json/lua_tower_mop_up.lua

module("modules.configs.excel2json.lua_tower_mop_up", package.seeall)

local lua_tower_mop_up = {}
local fields = {
	id = 1,
	reward = 3,
	layerNum = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_mop_up_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_mop_up, "configList", _configList)
	rawset(lua_tower_mop_up, "configDict", _configDict)
end

setmetatable(lua_tower_mop_up, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_mop_up.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_mop_up, "configList", nil)
	rawset(lua_tower_mop_up, "configDict", nil)
end

return lua_tower_mop_up
