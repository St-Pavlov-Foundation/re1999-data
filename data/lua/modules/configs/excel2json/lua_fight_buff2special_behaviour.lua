-- chunkname: @modules/configs/excel2json/lua_fight_buff2special_behaviour.lua

module("modules.configs.excel2json.lua_fight_buff2special_behaviour", package.seeall)

local lua_fight_buff2special_behaviour = {}
local fields = {
	behaviour = 2,
	param = 3,
	buffId = 1
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_buff2special_behaviour_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_buff2special_behaviour, "configList", _configList)
	rawset(lua_fight_buff2special_behaviour, "configDict", _configDict)
end

setmetatable(lua_fight_buff2special_behaviour, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_buff2special_behaviour.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_buff2special_behaviour, "configList", nil)
	rawset(lua_fight_buff2special_behaviour, "configDict", nil)
end

return lua_fight_buff2special_behaviour
