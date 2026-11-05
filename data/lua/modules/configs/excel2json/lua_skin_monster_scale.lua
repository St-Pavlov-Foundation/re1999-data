-- chunkname: @modules/configs/excel2json/lua_skin_monster_scale.lua

module("modules.configs.excel2json.lua_skin_monster_scale", package.seeall)

local lua_skin_monster_scale = {}
local fields = {
	effectName = 3,
	monsterId = 2,
	scale = 4,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_monster_scale_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_monster_scale, "configList", _configList)
	rawset(lua_skin_monster_scale, "configDict", _configDict)
end

setmetatable(lua_skin_monster_scale, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_monster_scale.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_monster_scale, "configList", nil)
	rawset(lua_skin_monster_scale, "configDict", nil)
end

return lua_skin_monster_scale
