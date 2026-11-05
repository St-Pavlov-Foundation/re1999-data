-- chunkname: @modules/configs/excel2json/lua_rouge_collection_trammels.lua

module("modules.configs.excel2json.lua_rouge_collection_trammels", package.seeall)

local lua_rouge_collection_trammels = {}
local fields = {
	id = 1,
	num = 2,
	ruleList = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge_collection_trammels_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_collection_trammels, "configList", _configList)
	rawset(lua_rouge_collection_trammels, "configDict", _configDict)
end

setmetatable(lua_rouge_collection_trammels, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_collection_trammels.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_collection_trammels, "configList", nil)
	rawset(lua_rouge_collection_trammels, "configDict", nil)
end

return lua_rouge_collection_trammels
