-- chunkname: @modules/configs/excel2json/lua_survival_equip_score.lua

module("modules.configs.excel2json.lua_survival_equip_score", package.seeall)

local lua_survival_equip_score = {}
local fields = {
	level = 3,
	worldlevel = 1,
	type = 2
}
local primaryKey = {
	"worldlevel",
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.survival_equip_score_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_equip_score, "configList", _configList)
	rawset(lua_survival_equip_score, "configDict", _configDict)
end

setmetatable(lua_survival_equip_score, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_equip_score.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_equip_score, "configList", nil)
	rawset(lua_survival_equip_score, "configDict", nil)
end

return lua_survival_equip_score
