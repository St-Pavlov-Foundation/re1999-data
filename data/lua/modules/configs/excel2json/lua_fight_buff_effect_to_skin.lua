-- chunkname: @modules/configs/excel2json/lua_fight_buff_effect_to_skin.lua

module("modules.configs.excel2json.lua_fight_buff_effect_to_skin", package.seeall)

local lua_fight_buff_effect_to_skin = {}
local fields = {
	buffId = 1,
	skinIdList = 2
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff_effect_to_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff_effect_to_skin, "configList", _configList)
	rawset(lua_fight_buff_effect_to_skin, "configDict", _configDict)
end

setmetatable(lua_fight_buff_effect_to_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff_effect_to_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff_effect_to_skin, "configList", nil)
	rawset(lua_fight_buff_effect_to_skin, "configDict", nil)
end

return lua_fight_buff_effect_to_skin
