-- chunkname: @modules/configs/excel2json/lua_rouge_special_trigger.lua

module("modules.configs.excel2json.lua_rouge_special_trigger", package.seeall)

local lua_rouge_special_trigger = {}
local fields = {
	eventCorrectWeight = 4,
	unlockTask = 8,
	reasonRange = 3,
	name = 2,
	eventGroupCorrectWeight = 5,
	shopGroupCorrectWeight = 6,
	inPictorial = 9,
	dropGroupCorrectWeight = 7,
	id = 1,
	isShow = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_special_trigger_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_special_trigger, "configList", _configList)
	rawset(lua_rouge_special_trigger, "configDict", _configDict)
end

setmetatable(lua_rouge_special_trigger, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_special_trigger.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_special_trigger, "configList", nil)
	rawset(lua_rouge_special_trigger, "configDict", nil)
end

return lua_rouge_special_trigger
