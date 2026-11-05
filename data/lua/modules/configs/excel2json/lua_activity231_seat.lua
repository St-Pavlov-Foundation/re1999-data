-- chunkname: @modules/configs/excel2json/lua_activity231_seat.lua

module("modules.configs.excel2json.lua_activity231_seat", package.seeall)

local lua_activity231_seat = {}
local fields = {
	cost = 4,
	preId = 3,
	id = 2,
	orientation = 5,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity231_seat_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity231_seat, "configList", _configList)
	rawset(lua_activity231_seat, "configDict", _configDict)
end

setmetatable(lua_activity231_seat, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity231_seat.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity231_seat, "configList", nil)
	rawset(lua_activity231_seat, "configDict", nil)
end

return lua_activity231_seat
