-- chunkname: @modules/configs/excel2json/lua_rouge_synthesis.lua

module("modules.configs.excel2json.lua_rouge_synthesis", package.seeall)

local lua_rouge_synthesis = {}
local fields = {
	id = 1,
	version = 2,
	product = 3,
	synthetics = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_synthesis_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_synthesis, "configList", _configList)
	rawset(lua_rouge_synthesis, "configDict", _configDict)
end

setmetatable(lua_rouge_synthesis, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_synthesis.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_synthesis, "configList", nil)
	rawset(lua_rouge_synthesis, "configDict", nil)
end

return lua_rouge_synthesis
