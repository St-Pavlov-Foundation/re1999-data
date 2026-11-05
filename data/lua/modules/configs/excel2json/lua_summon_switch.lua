-- chunkname: @modules/configs/excel2json/lua_summon_switch.lua

module("modules.configs.excel2json.lua_summon_switch", package.seeall)

local lua_summon_switch = {}
local fields = {
	itemId = 3,
	previewIcon = 5,
	resName = 6,
	id = 1,
	icon = 4,
	defaultUnlock = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.summon_switch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_summon_switch, "configList", _configList)
	rawset(lua_summon_switch, "configDict", _configDict)
end

setmetatable(lua_summon_switch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_summon_switch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_summon_switch, "configList", nil)
	rawset(lua_summon_switch, "configDict", nil)
end

return lua_summon_switch
