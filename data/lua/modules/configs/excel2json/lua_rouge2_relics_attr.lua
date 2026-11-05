-- chunkname: @modules/configs/excel2json/lua_rouge2_relics_attr.lua

module("modules.configs.excel2json.lua_rouge2_relics_attr", package.seeall)

local lua_rouge2_relics_attr = {}
local fields = {
	flag = 2,
	id = 1,
	type = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_relics_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_relics_attr, "configList", _configList)
	rawset(lua_rouge2_relics_attr, "configDict", _configDict)
end

setmetatable(lua_rouge2_relics_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_relics_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_relics_attr, "configList", nil)
	rawset(lua_rouge2_relics_attr, "configDict", nil)
end

return lua_rouge2_relics_attr
