-- chunkname: @modules/configs/excel2json/lua_equip_trial.lua

module("modules.configs.excel2json.lua_equip_trial", package.seeall)

local lua_equip_trial = {}
local fields = {
	equipId = 2,
	equipRefine = 4,
	equipLv = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.equip_trial_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_equip_trial, "configList", _configList)
	rawset(lua_equip_trial, "configDict", _configDict)
end

setmetatable(lua_equip_trial, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_equip_trial.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_equip_trial, "configList", nil)
	rawset(lua_equip_trial, "configDict", nil)
end

return lua_equip_trial
