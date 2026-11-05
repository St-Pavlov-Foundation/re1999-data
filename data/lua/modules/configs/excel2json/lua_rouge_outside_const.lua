-- chunkname: @modules/configs/excel2json/lua_rouge_outside_const.lua

module("modules.configs.excel2json.lua_rouge_outside_const", package.seeall)

local lua_rouge_outside_const = {}
local fields = {
	id = 2,
	season = 1,
	value = 3,
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
local configPath = "configs.rouge_outside_const_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_outside_const, "configList", _configList)
	rawset(lua_rouge_outside_const, "configDict", _configDict)
end

setmetatable(lua_rouge_outside_const, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_outside_const.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_outside_const, "configList", nil)
	rawset(lua_rouge_outside_const, "configDict", nil)
end

return lua_rouge_outside_const
