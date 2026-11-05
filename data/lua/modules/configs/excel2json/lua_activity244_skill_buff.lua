-- chunkname: @modules/configs/excel2json/lua_activity244_skill_buff.lua

module("modules.configs.excel2json.lua_activity244_skill_buff", package.seeall)

local lua_activity244_skill_buff = {}
local fields = {
	id = 1,
	buffEffectType = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity244_skill_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity244_skill_buff, "configList", _configList)
	rawset(lua_activity244_skill_buff, "configDict", _configDict)
end

setmetatable(lua_activity244_skill_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity244_skill_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity244_skill_buff, "configList", nil)
	rawset(lua_activity244_skill_buff, "configDict", nil)
end

return lua_activity244_skill_buff
