-- chunkname: @modules/configs/excel2json/lua_main_act_atmosphere.lua

module("modules.configs.excel2json.lua_main_act_atmosphere", package.seeall)

local lua_main_act_atmosphere = {}
local fields = {
	id = 1,
	mainView = 3,
	isShowActBg = 7,
	isShowLogo = 6,
	mainViewActBtn = 4,
	mainThumbnailViewActBg = 10,
	effectDuration = 2,
	mainViewActBtnPrefix = 5,
	mainThumbnailView = 8,
	isShowfx = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.main_act_atmosphere_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_main_act_atmosphere, "configList", _configList)
	rawset(lua_main_act_atmosphere, "configDict", _configDict)
end

setmetatable(lua_main_act_atmosphere, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_main_act_atmosphere.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_main_act_atmosphere, "configList", nil)
	rawset(lua_main_act_atmosphere, "configDict", nil)
end

return lua_main_act_atmosphere
