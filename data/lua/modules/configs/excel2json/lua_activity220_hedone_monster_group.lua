-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_monster_group.lua

module("modules.configs.excel2json.lua_activity220_hedone_monster_group", package.seeall)

local lua_activity220_hedone_monster_group = {}
local fields = {
	id = 1,
	monsters = 5,
	type = 2,
	baseAttrFactor = 4,
	weight = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_hedone_monster_group_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_hedone_monster_group, "configList", _configList)
	rawset(lua_activity220_hedone_monster_group, "configDict", _configDict)
end

setmetatable(lua_activity220_hedone_monster_group, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_hedone_monster_group.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_hedone_monster_group, "configList", nil)
	rawset(lua_activity220_hedone_monster_group, "configDict", nil)
end

return lua_activity220_hedone_monster_group
