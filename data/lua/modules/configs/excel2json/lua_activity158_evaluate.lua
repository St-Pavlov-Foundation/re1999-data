-- chunkname: @modules/configs/excel2json/lua_activity158_evaluate.lua

module("modules.configs.excel2json.lua_activity158_evaluate", package.seeall)

local lua_activity158_evaluate = {}
local fields = {
	id = 1,
	round = 2,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.activity158_evaluate_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity158_evaluate, "configList", _configList)
	rawset(lua_activity158_evaluate, "configDict", _configDict)
end

setmetatable(lua_activity158_evaluate, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity158_evaluate.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity158_evaluate, "configList", nil)
	rawset(lua_activity158_evaluate, "configDict", nil)
end

return lua_activity158_evaluate
