-- chunkname: @modules/configs/excel2json/lua_odyssey_option.lua

module("modules.configs.excel2json.lua_odyssey_option", package.seeall)

local lua_odyssey_option = {}
local fields = {
	reward = 6,
	id = 1,
	story = 8,
	subDesc = 5,
	notFinish = 3,
	unlockCondition = 2,
	dataBase = 7,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	subDesc = 2,
	desc = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_option_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_option, "configList", _configList)
	rawset(lua_odyssey_option, "configDict", _configDict)
end

setmetatable(lua_odyssey_option, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_option.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_option, "configList", nil)
	rawset(lua_odyssey_option, "configDict", nil)
end

return lua_odyssey_option
