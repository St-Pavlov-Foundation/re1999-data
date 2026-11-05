-- chunkname: @modules/configs/excel2json/lua_hero3124_buff_talent.lua

module("modules.configs.excel2json.lua_hero3124_buff_talent", package.seeall)

local lua_hero3124_buff_talent = {}
local fields = {
	buffId = 1,
	rank = 2
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.hero3124_buff_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_hero3124_buff_talent, "configList", _configList)
	rawset(lua_hero3124_buff_talent, "configDict", _configDict)
end

setmetatable(lua_hero3124_buff_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_hero3124_buff_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_hero3124_buff_talent, "configList", nil)
	rawset(lua_hero3124_buff_talent, "configDict", nil)
end

return lua_hero3124_buff_talent
