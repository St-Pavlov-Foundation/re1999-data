-- chunkname: @modules/configs/excel2json/lua_udimo_friend.lua

module("modules.configs.excel2json.lua_udimo_friend", package.seeall)

local lua_udimo_friend = {}
local fields = {
	emoji = 5,
	friendId = 2,
	udimo2 = 4,
	belongBG = 1,
	udimo1 = 3
}
local primaryKey = {
	"belongBG",
	"friendId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.udimo_friend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_udimo_friend, "configList", _configList)
	rawset(lua_udimo_friend, "configDict", _configDict)
end

setmetatable(lua_udimo_friend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_udimo_friend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_udimo_friend, "configList", nil)
	rawset(lua_udimo_friend, "configDict", nil)
end

return lua_udimo_friend
