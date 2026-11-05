-- chunkname: @modules/configs/excel2json/lua_monster_skin_custom_click_box.lua

module("modules.configs.excel2json.lua_monster_skin_custom_click_box", package.seeall)

local lua_monster_skin_custom_click_box = {}
local fields = {
	box = 2,
	monsterSkinId = 1
}
local primaryKey = {
	"monsterSkinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.monster_skin_custom_click_box_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_monster_skin_custom_click_box, "configList", _configList)
	rawset(lua_monster_skin_custom_click_box, "configDict", _configDict)
end

setmetatable(lua_monster_skin_custom_click_box, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_monster_skin_custom_click_box.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_monster_skin_custom_click_box, "configList", nil)
	rawset(lua_monster_skin_custom_click_box, "configDict", nil)
end

return lua_monster_skin_custom_click_box
