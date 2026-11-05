-- chunkname: @modules/configs/excel2json/lua_rogue_layer.lua

module("modules.configs.excel2json.lua_rogue_layer", package.seeall)

local lua_rogue_layer = {}
local fields = {
	attr = 3,
	difficulty = 1,
	layer = 2
}
local primaryKey = {
	"difficulty",
	"layer"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rogue_layer_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rogue_layer, "configList", _configList)
	rawset(lua_rogue_layer, "configDict", _configDict)
end

setmetatable(lua_rogue_layer, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rogue_layer.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rogue_layer, "configList", nil)
	rawset(lua_rogue_layer, "configDict", nil)
end

return lua_rogue_layer
