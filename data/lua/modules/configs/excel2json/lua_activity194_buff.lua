-- chunkname: @modules/configs/excel2json/lua_activity194_buff.lua

module("modules.configs.excel2json.lua_activity194_buff", package.seeall)

local lua_activity194_buff = {}
local fields = {
	effectDesc = 4,
	buffType = 2,
	buffId = 1,
	effectType = 3
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {
	effectDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity194_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity194_buff, "configList", _configList)
	rawset(lua_activity194_buff, "configDict", _configDict)
end

setmetatable(lua_activity194_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity194_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity194_buff, "configList", nil)
	rawset(lua_activity194_buff, "configDict", nil)
end

return lua_activity194_buff
