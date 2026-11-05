-- chunkname: @modules/configs/excel2json/lua_rouge_enchant.lua

module("modules.configs.excel2json.lua_rouge_enchant", package.seeall)

local lua_rouge_enchant = {}
local fields = {
	id = 1,
	name = 2,
	enchantState = 4,
	baseId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_enchant_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_enchant, "configList", _configList)
	rawset(lua_rouge_enchant, "configDict", _configDict)
end

setmetatable(lua_rouge_enchant, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_enchant.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_enchant, "configList", nil)
	rawset(lua_rouge_enchant, "configDict", nil)
end

return lua_rouge_enchant
