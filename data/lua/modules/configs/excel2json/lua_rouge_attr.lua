-- chunkname: @modules/configs/excel2json/lua_rouge_attr.lua

module("modules.configs.excel2json.lua_rouge_attr", package.seeall)

local lua_rouge_attr = {}
local fields = {
	id = 1,
	flag = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_attr_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_attr, "configList", _configList)
	rawset(lua_rouge_attr, "configDict", _configDict)
end

setmetatable(lua_rouge_attr, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_attr.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_attr, "configList", nil)
	rawset(lua_rouge_attr, "configDict", nil)
end

return lua_rouge_attr
