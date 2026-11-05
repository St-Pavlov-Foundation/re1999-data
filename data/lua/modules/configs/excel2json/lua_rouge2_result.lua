-- chunkname: @modules/configs/excel2json/lua_rouge2_result.lua

module("modules.configs.excel2json.lua_rouge2_result", package.seeall)

local lua_rouge2_result = {}
local fields = {
	priority = 4,
	triggerParam = 6,
	type = 2,
	id = 1,
	trigger = 5,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_result_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_result, "configList", _configList)
	rawset(lua_rouge2_result, "configDict", _configDict)
end

setmetatable(lua_rouge2_result, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_result.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_result, "configList", nil)
	rawset(lua_rouge2_result, "configDict", nil)
end

return lua_rouge2_result
