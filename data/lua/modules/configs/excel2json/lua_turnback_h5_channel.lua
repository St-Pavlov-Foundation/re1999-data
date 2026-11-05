-- chunkname: @modules/configs/excel2json/lua_turnback_h5_channel.lua

module("modules.configs.excel2json.lua_turnback_h5_channel", package.seeall)

local lua_turnback_h5_channel = {}
local fields = {
	id = 1,
	channelId = 2,
	testUrl = 4,
	url = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_h5_channel_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_h5_channel, "configList", _configList)
	rawset(lua_turnback_h5_channel, "configDict", _configDict)
end

setmetatable(lua_turnback_h5_channel, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_h5_channel.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_h5_channel, "configList", nil)
	rawset(lua_turnback_h5_channel, "configDict", nil)
end

return lua_turnback_h5_channel
