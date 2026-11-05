-- chunkname: @modules/configs/excel2json/lua_activity175.lua

module("modules.configs.excel2json.lua_activity175", package.seeall)

local lua_activity175 = {}
local fields = {
	res_gif1 = 3,
	res_pic = 2,
	activityId = 1,
	res_gif2 = 4
}
local primaryKey = {
	"activityId",
	"res_pic"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity175_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity175, "configList", _configList)
	rawset(lua_activity175, "configDict", _configDict)
end

setmetatable(lua_activity175, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity175.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity175, "configList", nil)
	rawset(lua_activity175, "configDict", nil)
end

return lua_activity175
