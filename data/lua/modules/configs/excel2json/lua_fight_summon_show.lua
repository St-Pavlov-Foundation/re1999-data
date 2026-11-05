-- chunkname: @modules/configs/excel2json/lua_fight_summon_show.lua

module("modules.configs.excel2json.lua_fight_summon_show", package.seeall)

local lua_fight_summon_show = {}
local fields = {
	audioId = 6,
	effect = 3,
	ingoreEffect = 7,
	skinId = 1,
	effectHangPoint = 5,
	effectTime = 4,
	actionName = 2
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_summon_show_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_summon_show, "configList", _configList)
	rawset(lua_fight_summon_show, "configDict", _configDict)
end

setmetatable(lua_fight_summon_show, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_summon_show.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_summon_show, "configList", nil)
	rawset(lua_fight_summon_show, "configDict", nil)
end

return lua_fight_summon_show
