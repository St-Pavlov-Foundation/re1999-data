-- chunkname: @modules/configs/excel2json/lua_teaching.lua

module("modules.configs.excel2json.lua_teaching", package.seeall)

local lua_teaching = {}
local fields = {
	detail = 4,
	name = 2,
	bonus = 6,
	battleTag = 5,
	id = 1,
	icon = 7,
	picture = 8,
	tagName = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	detail = 3,
	name = 1,
	tagName = 2
}
local _configList, _configDict
local configPath = "configs.teaching_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_teaching, "configList", _configList)
	rawset(lua_teaching, "configDict", _configDict)
end

setmetatable(lua_teaching, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_teaching.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_teaching, "configList", nil)
	rawset(lua_teaching, "configDict", nil)
end

return lua_teaching
