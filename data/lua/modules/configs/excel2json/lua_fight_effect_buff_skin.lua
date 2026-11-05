-- chunkname: @modules/configs/excel2json/lua_fight_effect_buff_skin.lua

module("modules.configs.excel2json.lua_fight_effect_buff_skin", package.seeall)

local lua_fight_effect_buff_skin = {}
local fields = {
	triggerAudio = 8,
	effectHang = 4,
	buffId = 1,
	skinId = 3,
	orEnemy = 2,
	delAudio = 9,
	effectPath = 5,
	audio = 10,
	triggerEffect = 6,
	delEffect = 7
}
local primaryKey = {
	"buffId",
	"orEnemy",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_effect_buff_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_effect_buff_skin, "configList", _configList)
	rawset(lua_fight_effect_buff_skin, "configDict", _configDict)
end

setmetatable(lua_fight_effect_buff_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_effect_buff_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_effect_buff_skin, "configList", nil)
	rawset(lua_fight_effect_buff_skin, "configDict", nil)
end

return lua_fight_effect_buff_skin
