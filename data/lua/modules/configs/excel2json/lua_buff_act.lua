-- chunkname: @modules/configs/excel2json/lua_buff_act.lua

module("modules.configs.excel2json.lua_buff_act", package.seeall)

local lua_buff_act = {}
local fields = {
	audioId = 7,
	effect = 5,
	effectHangPoint = 6,
	type = 2,
	id = 1,
	effectCondition = 4,
	effectTime = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.buff_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_buff_act, "configList", _configList)
	rawset(lua_buff_act, "configDict", _configDict)
end

setmetatable(lua_buff_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_buff_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_buff_act, "configList", nil)
	rawset(lua_buff_act, "configDict", nil)
end

return lua_buff_act
