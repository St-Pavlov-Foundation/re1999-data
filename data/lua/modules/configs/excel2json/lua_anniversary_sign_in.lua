-- chunkname: @modules/configs/excel2json/lua_anniversary_sign_in.lua

module("modules.configs.excel2json.lua_anniversary_sign_in", package.seeall)

local lua_anniversary_sign_in = {}
local fields = {
	skinid = 3,
	name = 6,
	skinlocation = 4,
	content = 7,
	signature = 5,
	activityId = 1,
	day = 2
}
local primaryKey = {
	"activityId",
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.anniversary_sign_in_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_anniversary_sign_in, "configList", _configList)
	rawset(lua_anniversary_sign_in, "configDict", _configDict)
end

setmetatable(lua_anniversary_sign_in, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_anniversary_sign_in.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_anniversary_sign_in, "configList", nil)
	rawset(lua_anniversary_sign_in, "configDict", nil)
end

return lua_anniversary_sign_in
