-- chunkname: @modules/configs/excel2json/lua_fight_sp_card_ly.lua

module("modules.configs.excel2json.lua_fight_sp_card_ly", package.seeall)

local lua_fight_sp_card_ly = {}
local fields = {
	id = 1,
	path = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_card_ly_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_card_ly, "configList", _configList)
	rawset(lua_fight_sp_card_ly, "configDict", _configDict)
end

setmetatable(lua_fight_sp_card_ly, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_card_ly.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_card_ly, "configList", nil)
	rawset(lua_fight_sp_card_ly, "configDict", nil)
end

return lua_fight_sp_card_ly
