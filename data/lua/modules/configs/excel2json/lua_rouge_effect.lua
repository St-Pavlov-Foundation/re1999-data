-- chunkname: @modules/configs/excel2json/lua_rouge_effect.lua

module("modules.configs.excel2json.lua_rouge_effect", package.seeall)

local lua_rouge_effect = {}
local fields = {
	tips = 2,
	typeParam = 5,
	type = 4,
	id = 1,
	version = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tips = 1
}
local _configList, _configDict
local configPath = "configs.rouge_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_effect, "configList", _configList)
	rawset(lua_rouge_effect, "configDict", _configDict)
end

setmetatable(lua_rouge_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_effect, "configList", nil)
	rawset(lua_rouge_effect, "configDict", nil)
end

return lua_rouge_effect
