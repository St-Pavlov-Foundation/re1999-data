-- chunkname: @modules/configs/excel2json/lua_rouge2_attr_drop.lua

module("modules.configs.excel2json.lua_rouge2_attr_drop", package.seeall)

local lua_rouge2_attr_drop = {}
local fields = {
	needNum = 5,
	level = 4,
	id = 1,
	career = 2,
	attr = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_attr_drop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_attr_drop, "configList", _configList)
	rawset(lua_rouge2_attr_drop, "configDict", _configDict)
end

setmetatable(lua_rouge2_attr_drop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_attr_drop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_attr_drop, "configList", nil)
	rawset(lua_rouge2_attr_drop, "configDict", nil)
end

return lua_rouge2_attr_drop
