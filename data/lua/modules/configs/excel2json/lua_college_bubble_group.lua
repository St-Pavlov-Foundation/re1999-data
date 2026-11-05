-- chunkname: @modules/configs/excel2json/lua_college_bubble_group.lua

module("modules.configs.excel2json.lua_college_bubble_group", package.seeall)

local lua_college_bubble_group = {}
local fields = {
	dailyPlayOnce = 4,
	weight = 5,
	type = 3,
	id = 1,
	pos = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.college_bubble_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_bubble_group, "configList", _configList)
	rawset(lua_college_bubble_group, "configDict", _configDict)
end

setmetatable(lua_college_bubble_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_bubble_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_bubble_group, "configList", nil)
	rawset(lua_college_bubble_group, "configDict", nil)
end

return lua_college_bubble_group
