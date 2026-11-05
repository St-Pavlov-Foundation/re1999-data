-- chunkname: @modules/configs/excel2json/lua_activity144_buff.lua

module("modules.configs.excel2json.lua_activity144_buff", package.seeall)

local lua_activity144_buff = {}
local fields = {
	effectParam = 5,
	effectType = 4,
	buffId = 2,
	type = 3,
	effectDesc = 6,
	reduction = 7,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"buffId"
}
local mlStringKey = {
	effectDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity144_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity144_buff, "configList", _configList)
	rawset(lua_activity144_buff, "configDict", _configDict)
end

setmetatable(lua_activity144_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity144_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity144_buff, "configList", nil)
	rawset(lua_activity144_buff, "configDict", nil)
end

return lua_activity144_buff
