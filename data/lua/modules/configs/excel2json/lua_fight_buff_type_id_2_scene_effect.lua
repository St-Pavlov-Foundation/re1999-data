-- chunkname: @modules/configs/excel2json/lua_fight_buff_type_id_2_scene_effect.lua

module("modules.configs.excel2json.lua_fight_buff_type_id_2_scene_effect", package.seeall)

local lua_fight_buff_type_id_2_scene_effect = {}
local fields = {
	reverseX = 4,
	effect = 2,
	delEffect = 5,
	audio = 7,
	id = 1,
	delAudio = 8,
	pos = 3,
	delTime = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_type_id_2_scene_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_type_id_2_scene_effect, "configList", _configList)
	rawset(lua_fight_buff_type_id_2_scene_effect, "configDict", _configDict)
end

setmetatable(lua_fight_buff_type_id_2_scene_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_type_id_2_scene_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_type_id_2_scene_effect, "configList", nil)
	rawset(lua_fight_buff_type_id_2_scene_effect, "configDict", nil)
end

return lua_fight_buff_type_id_2_scene_effect
