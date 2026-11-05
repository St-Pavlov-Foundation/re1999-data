-- chunkname: @modules/configs/excel2json/lua_skin_monster_hide_buff_effect.lua

module("modules.configs.excel2json.lua_skin_monster_hide_buff_effect", package.seeall)

local lua_skin_monster_hide_buff_effect = {}
local fields = {
	effectName = 2,
	exceptEffect = 3,
	skillId = 1
}
local primaryKey = {
	"skillId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_monster_hide_buff_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_monster_hide_buff_effect, "configList", _configList)
	rawset(lua_skin_monster_hide_buff_effect, "configDict", _configDict)
end

setmetatable(lua_skin_monster_hide_buff_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_monster_hide_buff_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_monster_hide_buff_effect, "configList", nil)
	rawset(lua_skin_monster_hide_buff_effect, "configDict", nil)
end

return lua_skin_monster_hide_buff_effect
