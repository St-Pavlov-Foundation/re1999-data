-- chunkname: @modules/configs/excel2json/lua_activity239.lua

module("modules.configs.excel2json.lua_activity239", package.seeall)

local lua_activity239 = {}
local fields = {
	text = 5,
	openTime = 7,
	preId = 3,
	pic = 6,
	id = 2,
	title = 4,
	activityId = 1,
	bonus = 8
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	text = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.activity239_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity239, "configList", _configList)
	rawset(lua_activity239, "configDict", _configDict)
end

setmetatable(lua_activity239, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity239.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity239, "configList", nil)
	rawset(lua_activity239, "configDict", nil)
end

return lua_activity239
