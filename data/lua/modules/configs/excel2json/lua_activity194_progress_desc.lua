-- chunkname: @modules/configs/excel2json/lua_activity194_progress_desc.lua

module("modules.configs.excel2json.lua_activity194_progress_desc", package.seeall)

local lua_activity194_progress_desc = {}
local fields = {
	roundRange = 5,
	energyRange = 3,
	energyDesc = 4,
	type = 2,
	roundDesc = 6,
	condition = 1
}
local primaryKey = {
	"condition"
}
local mlStringKey = {
	energyDesc = 1,
	roundDesc = 2
}
local _configList, _configDict
local configPath = "configs.activity194_progress_desc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_progress_desc, "configList", _configList)
	rawset(lua_activity194_progress_desc, "configDict", _configDict)
end

setmetatable(lua_activity194_progress_desc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_progress_desc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_progress_desc, "configList", nil)
	rawset(lua_activity194_progress_desc, "configDict", nil)
end

return lua_activity194_progress_desc
