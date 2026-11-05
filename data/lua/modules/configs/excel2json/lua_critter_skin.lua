-- chunkname: @modules/configs/excel2json/lua_critter_skin.lua

module("modules.configs.excel2json.lua_critter_skin", package.seeall)

local lua_critter_skin = {}
local fields = {
	handEffects = 5,
	spine = 4,
	largeIcon = 3,
	id = 1,
	headIcon = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.critter_skin_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_critter_skin, "configList", _configList)
	rawset(lua_critter_skin, "configDict", _configDict)
end

setmetatable(lua_critter_skin, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_critter_skin.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_critter_skin, "configList", nil)
	rawset(lua_critter_skin, "configDict", nil)
end

return lua_critter_skin
