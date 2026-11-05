-- chunkname: @modules/configs/excel2json/lua_odyssey_dialog_element.lua

module("modules.configs.excel2json.lua_odyssey_dialog_element", package.seeall)

local lua_odyssey_dialog_element = {}
local fields = {
	stepId = 2,
	name = 6,
	nextStep = 3,
	optionList = 5,
	id = 1,
	picture = 4,
	desc = 7
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.odyssey_dialog_element_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_dialog_element, "configList", _configList)
	rawset(lua_odyssey_dialog_element, "configDict", _configDict)
end

setmetatable(lua_odyssey_dialog_element, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_dialog_element.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_dialog_element, "configList", nil)
	rawset(lua_odyssey_dialog_element, "configDict", nil)
end

return lua_odyssey_dialog_element
