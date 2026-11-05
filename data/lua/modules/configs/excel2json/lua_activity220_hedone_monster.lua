-- chunkname: @modules/configs/excel2json/lua_activity220_hedone_monster.lua

module("modules.configs.excel2json.lua_activity220_hedone_monster", package.seeall)

local lua_activity220_hedone_monster = {}
local fields = {
	showHp = 7,
	baseAttr = 2,
	exp = 6,
	moveSpeed = 5,
	id = 1,
	image = 3,
	scale = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity220_hedone_monster_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity220_hedone_monster, "configList", _configList)
	rawset(lua_activity220_hedone_monster, "configDict", _configDict)
end

setmetatable(lua_activity220_hedone_monster, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity220_hedone_monster.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity220_hedone_monster, "configList", nil)
	rawset(lua_activity220_hedone_monster, "configDict", nil)
end

return lua_activity220_hedone_monster
