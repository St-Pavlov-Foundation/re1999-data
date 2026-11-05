-- chunkname: @modules/configs/excel2json/lua_player_bg.lua

module("modules.configs.excel2json.lua_player_bg", package.seeall)

local lua_player_bg = {}
local fields = {
	bg = 6,
	name = 2,
	item = 4,
	chatbg = 8,
	bgEffect = 7,
	desc = 3,
	infobg = 9,
	id = 1,
	lockdesc = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	lockdesc = 3,
	name = 1,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.player_bg_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_player_bg, "configList", _configList)
	rawset(lua_player_bg, "configDict", _configDict)
end

setmetatable(lua_player_bg, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_player_bg.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_player_bg, "configList", nil)
	rawset(lua_player_bg, "configDict", nil)
end

return lua_player_bg
