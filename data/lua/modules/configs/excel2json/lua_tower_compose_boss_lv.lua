-- chunkname: @modules/configs/excel2json/lua_tower_compose_boss_lv.lua

module("modules.configs.excel2json.lua_tower_compose_boss_lv", package.seeall)

local lua_tower_compose_boss_lv = {}
local fields = {
	levelReq = 3,
	templateChange = 4,
	level = 2,
	episodeId = 1
}
local primaryKey = {
	"episodeId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_compose_boss_lv_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_compose_boss_lv, "configList", _configList)
	rawset(lua_tower_compose_boss_lv, "configDict", _configDict)
end

setmetatable(lua_tower_compose_boss_lv, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_compose_boss_lv.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_compose_boss_lv, "configList", nil)
	rawset(lua_tower_compose_boss_lv, "configDict", nil)
end

return lua_tower_compose_boss_lv
