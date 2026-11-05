-- chunkname: @modules/configs/excel2json/lua_fight_rouge2_music.lua

module("modules.configs.excel2json.lua_fight_rouge2_music", package.seeall)

local lua_fight_rouge2_music = {}
local fields = {
	id = 1,
	name = 2,
	icon1 = 3,
	icon2 = 4
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.fight_rouge2_music_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_rouge2_music, "configList", _configList)
	rawset(lua_fight_rouge2_music, "configDict", _configDict)
end

setmetatable(lua_fight_rouge2_music, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_rouge2_music.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_rouge2_music, "configList", nil)
	rawset(lua_fight_rouge2_music, "configDict", nil)
end

return lua_fight_rouge2_music
