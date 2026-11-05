-- chunkname: @modules/configs/excel2json/lua_rouge_limit_group.lua

module("modules.configs.excel2json.lua_rouge_limit_group", package.seeall)

local lua_rouge_limit_group = {}
local fields = {
	version = 2,
	unlockCondition = 5,
	icon = 6,
	id = 1,
	title = 3,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge_limit_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_limit_group, "configList", _configList)
	rawset(lua_rouge_limit_group, "configDict", _configDict)
end

setmetatable(lua_rouge_limit_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_limit_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_limit_group, "configList", nil)
	rawset(lua_rouge_limit_group, "configDict", nil)
end

return lua_rouge_limit_group
