-- chunkname: @modules/configs/excel2json/lua_fight_kill.lua

module("modules.configs.excel2json.lua_fight_kill", package.seeall)

local lua_fight_kill = {}
local fields = {
	audio = 4,
	effect = 2,
	skinId = 1,
	effectHangPoint = 3,
	duration = 5,
	waitTime = 6
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_kill_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_kill, "configList", _configList)
	rawset(lua_fight_kill, "configDict", _configDict)
end

setmetatable(lua_fight_kill, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_kill.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_kill, "configList", nil)
	rawset(lua_fight_kill, "configDict", nil)
end

return lua_fight_kill
