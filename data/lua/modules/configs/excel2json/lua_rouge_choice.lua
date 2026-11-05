-- chunkname: @modules/configs/excel2json/lua_rouge_choice.lua

module("modules.configs.excel2json.lua_rouge_choice", package.seeall)

local lua_rouge_choice = {}
local fields = {
	interactive = 8,
	display = 9,
	selectedDesc = 7,
	unlockParam = 4,
	title = 5,
	desc = 6,
	unlockType = 3,
	id = 1,
	version = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1,
	selectedDesc = 3,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.rouge_choice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_choice, "configList", _configList)
	rawset(lua_rouge_choice, "configDict", _configDict)
end

setmetatable(lua_rouge_choice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_choice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_choice, "configList", nil)
	rawset(lua_rouge_choice, "configDict", nil)
end

return lua_rouge_choice
