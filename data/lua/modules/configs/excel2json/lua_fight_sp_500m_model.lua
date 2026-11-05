-- chunkname: @modules/configs/excel2json/lua_fight_sp_500m_model.lua

module("modules.configs.excel2json.lua_fight_sp_500m_model", package.seeall)

local lua_fight_sp_500m_model = {}
local fields = {
	headIcon = 5,
	behind = 4,
	headIconName = 6,
	front = 2,
	monsterId = 1,
	center = 3
}
local primaryKey = {
	"monsterId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_500m_model_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_500m_model, "configList", _configList)
	rawset(lua_fight_sp_500m_model, "configDict", _configDict)
end

setmetatable(lua_fight_sp_500m_model, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_500m_model.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_500m_model, "configList", nil)
	rawset(lua_fight_sp_500m_model, "configDict", nil)
end

return lua_fight_sp_500m_model
