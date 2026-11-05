-- chunkname: @modules/configs/excel2json/lua_activity244_talent_branch.lua

module("modules.configs.excel2json.lua_activity244_talent_branch", package.seeall)

local lua_activity244_talent_branch = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3,
	nodeBg = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity244_talent_branch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_talent_branch, "configList", _configList)
	rawset(lua_activity244_talent_branch, "configDict", _configDict)
end

setmetatable(lua_activity244_talent_branch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_talent_branch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_talent_branch, "configList", nil)
	rawset(lua_activity244_talent_branch, "configDict", nil)
end

return lua_activity244_talent_branch
