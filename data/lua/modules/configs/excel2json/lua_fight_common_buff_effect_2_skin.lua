-- chunkname: @modules/configs/excel2json/lua_fight_common_buff_effect_2_skin.lua

module("modules.configs.excel2json.lua_fight_common_buff_effect_2_skin", package.seeall)

local lua_fight_common_buff_effect_2_skin = {}
local fields = {
	audio = 5,
	effectHang = 3,
	buffId = 1,
	skinId = 2,
	duration = 6,
	effectPath = 4
}
local primaryKey = {
	"buffId",
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_common_buff_effect_2_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_common_buff_effect_2_skin, "configList", _configList)
	rawset(lua_fight_common_buff_effect_2_skin, "configDict", _configDict)
end

setmetatable(lua_fight_common_buff_effect_2_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_common_buff_effect_2_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_common_buff_effect_2_skin, "configList", nil)
	rawset(lua_fight_common_buff_effect_2_skin, "configDict", nil)
end

return lua_fight_common_buff_effect_2_skin
