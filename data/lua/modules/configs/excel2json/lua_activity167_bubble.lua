-- chunkname: @modules/configs/excel2json/lua_activity167_bubble.lua

module("modules.configs.excel2json.lua_activity167_bubble", package.seeall)

local lua_activity167_bubble = {}
local fields = {
	interactId = 4,
	content = 6,
	id = 2,
	icon = 5,
	activityId = 1,
	step = 3
}
local primaryKey = {
	"activityId",
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity167_bubble_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity167_bubble, "configList", _configList)
	rawset(lua_activity167_bubble, "configDict", _configDict)
end

setmetatable(lua_activity167_bubble, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity167_bubble.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity167_bubble, "configList", nil)
	rawset(lua_activity167_bubble, "configDict", nil)
end

return lua_activity167_bubble
