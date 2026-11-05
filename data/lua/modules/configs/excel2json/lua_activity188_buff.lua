-- chunkname: @modules/configs/excel2json/lua_activity188_buff.lua

module("modules.configs.excel2json.lua_activity188_buff", package.seeall)

local lua_activity188_buff = {}
local fields = {
	desc = 6,
	name = 5,
	buffId = 2,
	icon = 7,
	maxLayer = 4,
	activityId = 1,
	laminate = 3
}
local primaryKey = {
	"activityId",
	"buffId"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity188_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity188_buff, "configList", _configList)
	rawset(lua_activity188_buff, "configDict", _configDict)
end

setmetatable(lua_activity188_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity188_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity188_buff, "configList", nil)
	rawset(lua_activity188_buff, "configDict", nil)
end

return lua_activity188_buff
