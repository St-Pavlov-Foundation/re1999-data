-- chunkname: @modules/configs/excel2json/lua_fight_buff_layer_effect_nana.lua

module("modules.configs.excel2json.lua_fight_buff_layer_effect_nana", package.seeall)

local lua_fight_buff_layer_effect_nana = {}
local fields = {
	effectRoot = 5,
	effect = 4,
	effectAudio = 6,
	skinId = 2,
	id = 1,
	duration = 7,
	layer = 3
}
local primaryKey = {
	"id",
	"skinId",
	"layer"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_layer_effect_nana_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_layer_effect_nana, "configList", _configList)
	rawset(lua_fight_buff_layer_effect_nana, "configDict", _configDict)
end

setmetatable(lua_fight_buff_layer_effect_nana, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_layer_effect_nana.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_layer_effect_nana, "configList", nil)
	rawset(lua_fight_buff_layer_effect_nana, "configDict", nil)
end

return lua_fight_buff_layer_effect_nana
