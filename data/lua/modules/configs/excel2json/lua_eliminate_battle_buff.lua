-- chunkname: @modules/configs/excel2json/lua_eliminate_battle_buff.lua

module("modules.configs.excel2json.lua_eliminate_battle_buff", package.seeall)

local lua_eliminate_battle_buff = {}
local fields = {
	triggerPoint = 2,
	effect = 3,
	name = 6,
	icon = 8,
	id = 1,
	cover = 4,
	limit = 5,
	desc = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.eliminate_battle_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_eliminate_battle_buff, "configList", _configList)
	rawset(lua_eliminate_battle_buff, "configDict", _configDict)
end

setmetatable(lua_eliminate_battle_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_eliminate_battle_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_eliminate_battle_buff, "configList", nil)
	rawset(lua_eliminate_battle_buff, "configDict", nil)
end

return lua_eliminate_battle_buff
