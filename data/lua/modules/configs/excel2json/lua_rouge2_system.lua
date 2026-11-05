-- chunkname: @modules/configs/excel2json/lua_rouge2_system.lua

module("modules.configs.excel2json.lua_rouge2_system", package.seeall)

local lua_rouge2_system = {}
local fields = {
	color = 5,
	bg = 6,
	recommendAttribute = 3,
	visible = 8,
	id = 1,
	icon = 2,
	bgColor = 7,
	desc = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.rouge2_system_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_system, "configList", _configList)
	rawset(lua_rouge2_system, "configDict", _configDict)
end

setmetatable(lua_rouge2_system, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_system.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_system, "configList", nil)
	rawset(lua_rouge2_system, "configDict", nil)
end

return lua_rouge2_system
