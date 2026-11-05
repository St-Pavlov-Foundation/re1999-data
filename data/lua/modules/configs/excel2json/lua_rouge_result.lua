-- chunkname: @modules/configs/excel2json/lua_rouge_result.lua

module("modules.configs.excel2json.lua_rouge_result", package.seeall)

local lua_rouge_result = {}
local fields = {
	id = 2,
	priority = 5,
	triggerParam = 7,
	type = 3,
	season = 1,
	trigger = 6,
	desc = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_result_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_result, "configList", _configList)
	rawset(lua_rouge_result, "configDict", _configDict)
end

setmetatable(lua_rouge_result, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_result.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_result, "configList", nil)
	rawset(lua_rouge_result, "configDict", nil)
end

return lua_rouge_result
