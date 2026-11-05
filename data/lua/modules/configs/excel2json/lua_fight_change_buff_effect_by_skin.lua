-- chunkname: @modules/configs/excel2json/lua_fight_change_buff_effect_by_skin.lua

module("modules.configs.excel2json.lua_fight_change_buff_effect_by_skin", package.seeall)

local lua_fight_change_buff_effect_by_skin = {}
local fields = {
	effectPath = 1,
	changedPath = 4,
	audio = 7,
	skinId = 3,
	effectHangPoint = 6,
	duration = 5,
	target = 2
}
local primaryKey = {
	"effectPath",
	"target",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_change_buff_effect_by_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_change_buff_effect_by_skin, "configList", _configList)
	rawset(lua_fight_change_buff_effect_by_skin, "configDict", _configDict)
end

setmetatable(lua_fight_change_buff_effect_by_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_change_buff_effect_by_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_change_buff_effect_by_skin, "configList", nil)
	rawset(lua_fight_change_buff_effect_by_skin, "configDict", nil)
end

return lua_fight_change_buff_effect_by_skin
