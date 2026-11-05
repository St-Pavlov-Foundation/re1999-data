-- chunkname: @modules/configs/excel2json/lua_assassin_buff.lua

module("modules.configs.excel2json.lua_assassin_buff", package.seeall)

local lua_assassin_buff = {}
local fields = {
	buffEffect = 4,
	effectId = 5,
	buffId = 1,
	type = 2,
	duration = 3
}
local primaryKey = {
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_buff, "configList", _configList)
	rawset(lua_assassin_buff, "configDict", _configDict)
end

setmetatable(lua_assassin_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_buff, "configList", nil)
	rawset(lua_assassin_buff, "configDict", nil)
end

return lua_assassin_buff
