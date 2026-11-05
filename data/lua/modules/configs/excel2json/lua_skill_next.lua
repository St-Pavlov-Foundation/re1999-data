-- chunkname: @modules/configs/excel2json/lua_skill_next.lua

module("modules.configs.excel2json.lua_skill_next", package.seeall)

local lua_skill_next = {}
local fields = {
	id = 1,
	nextId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skill_next_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skill_next, "configList", _configList)
	rawset(lua_skill_next, "configDict", _configDict)
end

setmetatable(lua_skill_next, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skill_next.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skill_next, "configList", nil)
	rawset(lua_skill_next, "configDict", nil)
end

return lua_skill_next
