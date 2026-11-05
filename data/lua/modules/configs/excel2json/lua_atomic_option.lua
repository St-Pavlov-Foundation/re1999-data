-- chunkname: @modules/configs/excel2json/lua_atomic_option.lua

module("modules.configs.excel2json.lua_atomic_option", package.seeall)

local lua_atomic_option = {}
local fields = {
	reward = 6,
	id = 1,
	warning = 7,
	story = 9,
	unlockCondition = 2,
	dataBase = 8,
	desc = 4,
	subDesc = 5,
	notFinish = 3,
	puzzle = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	subDesc = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.atomic_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_option, "configList", _configList)
	rawset(lua_atomic_option, "configDict", _configDict)
end

setmetatable(lua_atomic_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_option, "configList", nil)
	rawset(lua_atomic_option, "configDict", nil)
end

return lua_atomic_option
