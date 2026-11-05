-- chunkname: @modules/configs/excel2json/lua_bossrush_skin_effect.lua

module("modules.configs.excel2json.lua_bossrush_skin_effect", package.seeall)

local lua_bossrush_skin_effect = {}
local fields = {
	effects = 3,
	scales = 5,
	id = 1,
	stage = 2,
	hangpoints = 4
}
local primaryKey = {
	"id",
	"stage"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.bossrush_skin_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bossrush_skin_effect, "configList", _configList)
	rawset(lua_bossrush_skin_effect, "configDict", _configDict)
end

setmetatable(lua_bossrush_skin_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bossrush_skin_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bossrush_skin_effect, "configList", nil)
	rawset(lua_bossrush_skin_effect, "configDict", nil)
end

return lua_bossrush_skin_effect
