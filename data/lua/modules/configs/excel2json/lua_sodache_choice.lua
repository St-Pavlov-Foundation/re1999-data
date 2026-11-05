-- chunkname: @modules/configs/excel2json/lua_sodache_choice.lua

module("modules.configs.excel2json.lua_sodache_choice", package.seeall)

local lua_sodache_choice = {}
local fields = {
	choiceIds0 = 16,
	descBigSuccess = 20,
	verifyCard = 9,
	verifyDesc = 11,
	initialSelect = 3,
	eventId = 2,
	selectCond = 5,
	desc = 13,
	descLose = 14,
	dialogSuccess = 18,
	choiceIds1 = 19,
	autoCard = 7,
	forceCard = 8,
	dialogBigSuccess = 21,
	choiceIds2 = 22,
	baseDice = 6,
	descSuccess = 17,
	dialogDefault = 4,
	verifyCond = 10,
	dialogLose = 15,
	id = 1,
	battleList = 12
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	descLose = 3,
	descBigSuccess = 5,
	verifyDesc = 1,
	descSuccess = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.sodache_choice_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_sodache_choice, "configList", _configList)
	rawset(lua_sodache_choice, "configDict", _configDict)
end

setmetatable(lua_sodache_choice, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_sodache_choice.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_sodache_choice, "configList", nil)
	rawset(lua_sodache_choice, "configDict", nil)
end

return lua_sodache_choice
