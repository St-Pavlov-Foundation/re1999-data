-- chunkname: @modules/configs/excel2json/lua_weekwalk_buff.lua

module("modules.configs.excel2json.lua_weekwalk_buff", package.seeall)

local lua_weekwalk_buff = {}
local fields = {
	param = 4,
	name = 7,
	rare = 9,
	type = 3,
	preBuff = 5,
	desc = 8,
	replaceBuff = 6,
	id = 1,
	icon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.weekwalk_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_buff, "configList", _configList)
	rawset(lua_weekwalk_buff, "configDict", _configDict)
end

setmetatable(lua_weekwalk_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_buff, "configList", nil)
	rawset(lua_weekwalk_buff, "configDict", nil)
end

return lua_weekwalk_buff
