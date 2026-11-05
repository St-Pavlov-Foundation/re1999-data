-- chunkname: @modules/configs/excel2json/lua_activity132_content.lua

module("modules.configs.excel2json.lua_activity132_content", package.seeall)

local lua_activity132_content = {}
local fields = {
	content = 3,
	activityId = 1,
	contentId = 2,
	unlockDesc = 5,
	condition = 4
}
local primaryKey = {
	"activityId",
	"contentId"
}
local mlStringKey = {
	content = 1,
	unlockDesc = 2
}
local _configList, _configDict
local configPath = "configs.activity132_content_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity132_content, "configList", _configList)
	rawset(lua_activity132_content, "configDict", _configDict)
end

setmetatable(lua_activity132_content, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity132_content.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity132_content, "configList", nil)
	rawset(lua_activity132_content, "configDict", nil)
end

return lua_activity132_content
