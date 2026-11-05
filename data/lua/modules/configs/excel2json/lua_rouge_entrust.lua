-- chunkname: @modules/configs/excel2json/lua_rouge_entrust.lua

module("modules.configs.excel2json.lua_rouge_entrust", package.seeall)

local lua_rouge_entrust = {}
local fields = {
	interactive = 4,
	param = 3,
	incompleteEffect = 5,
	type = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_entrust_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_entrust, "configList", _configList)
	rawset(lua_rouge_entrust, "configDict", _configDict)
end

setmetatable(lua_rouge_entrust, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_entrust.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_entrust, "configList", nil)
	rawset(lua_rouge_entrust, "configDict", nil)
end

return lua_rouge_entrust
