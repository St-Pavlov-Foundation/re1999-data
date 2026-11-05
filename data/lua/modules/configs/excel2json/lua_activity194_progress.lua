-- chunkname: @modules/configs/excel2json/lua_activity194_progress.lua

module("modules.configs.excel2json.lua_activity194_progress", package.seeall)

local lua_activity194_progress = {}
local fields = {
	progressNum = 4,
	progressChange = 3,
	condition = 2,
	optionId = 1
}
local primaryKey = {
	"optionId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity194_progress_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_progress, "configList", _configList)
	rawset(lua_activity194_progress, "configDict", _configDict)
end

setmetatable(lua_activity194_progress, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_progress.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_progress, "configList", nil)
	rawset(lua_activity194_progress, "configDict", nil)
end

return lua_activity194_progress
