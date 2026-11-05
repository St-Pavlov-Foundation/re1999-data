-- chunkname: @modules/configs/excel2json/lua_odyssey_option_element.lua

module("modules.configs.excel2json.lua_odyssey_option_element", package.seeall)

local lua_odyssey_option_element = {}
local fields = {
	title = 3,
	optionList = 2,
	id = 1,
	image = 4,
	desc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_option_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_option_element, "configList", _configList)
	rawset(lua_odyssey_option_element, "configDict", _configDict)
end

setmetatable(lua_odyssey_option_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_option_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_option_element, "configList", nil)
	rawset(lua_odyssey_option_element, "configDict", nil)
end

return lua_odyssey_option_element
