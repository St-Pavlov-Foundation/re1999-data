-- chunkname: @modules/configs/excel2json/lua_rouge2_entrust.lua

module("modules.configs.excel2json.lua_rouge2_entrust", package.seeall)

local lua_rouge2_entrust = {}
local fields = {
	param = 3,
	resultDesc = 5,
	type = 2,
	id = 1,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	resultDesc = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_entrust_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_entrust, "configList", _configList)
	rawset(lua_rouge2_entrust, "configDict", _configDict)
end

setmetatable(lua_rouge2_entrust, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_entrust.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_entrust, "configList", nil)
	rawset(lua_rouge2_entrust, "configDict", nil)
end

return lua_rouge2_entrust
