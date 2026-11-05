-- chunkname: @modules/configs/excel2json/lua_rouge_limit.lua

module("modules.configs.excel2json.lua_rouge_limit", package.seeall)

local lua_rouge_limit = {}
local fields = {
	group = 3,
	startView = 8,
	riskValue = 7,
	title = 5,
	desc = 6,
	initCollections = 9,
	id = 1,
	version = 2,
	level = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge_limit_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_limit, "configList", _configList)
	rawset(lua_rouge_limit, "configDict", _configDict)
end

setmetatable(lua_rouge_limit, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_limit.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_limit, "configList", nil)
	rawset(lua_rouge_limit, "configDict", nil)
end

return lua_rouge_limit
