-- chunkname: @modules/configs/excel2json/lua_fight_sp_wuerlixi_monster_star_position_offset.lua

module("modules.configs.excel2json.lua_fight_sp_wuerlixi_monster_star_position_offset", package.seeall)

local lua_fight_sp_wuerlixi_monster_star_position_offset = {}
local fields = {
	offsetY = 3,
	monsterId = 1,
	offsetX = 2
}
local primaryKey = {
	"monsterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_wuerlixi_monster_star_position_offset_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_wuerlixi_monster_star_position_offset, "configList", _configList)
	rawset(lua_fight_sp_wuerlixi_monster_star_position_offset, "configDict", _configDict)
end

setmetatable(lua_fight_sp_wuerlixi_monster_star_position_offset, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_wuerlixi_monster_star_position_offset.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_wuerlixi_monster_star_position_offset, "configList", nil)
	rawset(lua_fight_sp_wuerlixi_monster_star_position_offset, "configDict", nil)
end

return lua_fight_sp_wuerlixi_monster_star_position_offset
