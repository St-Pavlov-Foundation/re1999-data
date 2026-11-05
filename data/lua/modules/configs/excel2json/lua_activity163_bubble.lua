-- chunkname: @modules/configs/excel2json/lua_activity163_bubble.lua

module("modules.configs.excel2json.lua_activity163_bubble", package.seeall)

local lua_activity163_bubble = {}
local fields = {
	stepId = 2,
	direction = 5,
	nextStep = 3,
	content = 6,
	id = 1,
	bubbleType = 4
}
local primaryKey = {
	"id",
	"stepId"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity163_bubble_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity163_bubble, "configList", _configList)
	rawset(lua_activity163_bubble, "configDict", _configDict)
end

setmetatable(lua_activity163_bubble, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity163_bubble.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity163_bubble, "configList", nil)
	rawset(lua_activity163_bubble, "configDict", nil)
end

return lua_activity163_bubble
