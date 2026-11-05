-- chunkname: @modules/configs/excel2json/lua_fight_de_lei_ke_slider_up.lua

module("modules.configs.excel2json.lua_fight_de_lei_ke_slider_up", package.seeall)

local lua_fight_de_lei_ke_slider_up = {}
local fields = {
	audioId = 4,
	effectHang = 3,
	destroyTime = 5,
	effect = 2,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_de_lei_ke_slider_up_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_de_lei_ke_slider_up, "configList", _configList)
	rawset(lua_fight_de_lei_ke_slider_up, "configDict", _configDict)
end

setmetatable(lua_fight_de_lei_ke_slider_up, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_de_lei_ke_slider_up.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_de_lei_ke_slider_up, "configList", nil)
	rawset(lua_fight_de_lei_ke_slider_up, "configDict", nil)
end

return lua_fight_de_lei_ke_slider_up
