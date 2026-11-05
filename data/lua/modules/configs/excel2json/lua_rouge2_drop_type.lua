-- chunkname: @modules/configs/excel2json/lua_rouge2_drop_type.lua

module("modules.configs.excel2json.lua_rouge2_drop_type", package.seeall)

local lua_rouge2_drop_type = {}
local fields = {
	id = 1,
	refreshCost = 3,
	selectCount = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_drop_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_drop_type, "configList", _configList)
	rawset(lua_rouge2_drop_type, "configDict", _configDict)
end

setmetatable(lua_rouge2_drop_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_drop_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_drop_type, "configList", nil)
	rawset(lua_rouge2_drop_type, "configDict", nil)
end

return lua_rouge2_drop_type
