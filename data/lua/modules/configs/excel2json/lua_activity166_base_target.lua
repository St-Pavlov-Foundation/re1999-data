-- chunkname: @modules/configs/excel2json/lua_activity166_base_target.lua

module("modules.configs.excel2json.lua_activity166_base_target", package.seeall)

local lua_activity166_base_target = {}
local fields = {
	score = 6,
	targetParam = 5,
	targetType = 4,
	targetId = 3,
	baseId = 2,
	targetDesc = 7,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"baseId",
	"targetId"
}
local mlStringKey = {
	targetDesc = 1
}
local _configList, _configDict
local configPath = "configs.activity166_base_target_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_base_target, "configList", _configList)
	rawset(lua_activity166_base_target, "configDict", _configDict)
end

setmetatable(lua_activity166_base_target, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_base_target.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_base_target, "configList", nil)
	rawset(lua_activity166_base_target, "configDict", nil)
end

return lua_activity166_base_target
