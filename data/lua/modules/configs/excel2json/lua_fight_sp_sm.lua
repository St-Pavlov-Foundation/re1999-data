-- chunkname: @modules/configs/excel2json/lua_fight_sp_sm.lua

module("modules.configs.excel2json.lua_fight_sp_sm", package.seeall)

local lua_fight_sp_sm = {}
local fields = {
	audioId = 5,
	action = 3,
	buffId = 2,
	skinId = 1,
	duration = 6,
	nextActionName = 7,
	actionName = 4
}
local primaryKey = {
	"skinId",
	"buffId",
	"action"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_sp_sm_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_sp_sm, "configList", _configList)
	rawset(lua_fight_sp_sm, "configDict", _configDict)
end

setmetatable(lua_fight_sp_sm, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_sp_sm.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_sp_sm, "configList", nil)
	rawset(lua_fight_sp_sm, "configDict", nil)
end

return lua_fight_sp_sm
