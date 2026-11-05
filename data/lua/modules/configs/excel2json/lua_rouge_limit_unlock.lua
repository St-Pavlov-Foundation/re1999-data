-- chunkname: @modules/configs/excel2json/lua_rouge_limit_unlock.lua

module("modules.configs.excel2json.lua_rouge_limit_unlock", package.seeall)

local lua_rouge_limit_unlock = {}
local fields = {
	style = 4,
	unlockCost = 5,
	skillId = 3,
	id = 1,
	version = 2
}
local primaryKey = {
	"id",
	"version"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_limit_unlock_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_limit_unlock, "configList", _configList)
	rawset(lua_rouge_limit_unlock, "configDict", _configDict)
end

setmetatable(lua_rouge_limit_unlock, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_limit_unlock.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_limit_unlock, "configList", nil)
	rawset(lua_rouge_limit_unlock, "configDict", nil)
end

return lua_rouge_limit_unlock
