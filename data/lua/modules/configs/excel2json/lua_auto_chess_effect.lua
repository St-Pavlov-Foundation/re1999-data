-- chunkname: @modules/configs/excel2json/lua_auto_chess_effect.lua

module("modules.configs.excel2json.lua_auto_chess_effect", package.seeall)

local lua_auto_chess_effect = {}
local fields = {
	tag = 2,
	subtag = 3,
	nameDown = 5,
	type = 6,
	target = 9,
	offset = 11,
	nameUp = 4,
	duration = 12,
	loop = 8,
	playertype = 7,
	soundId = 13,
	id = 1,
	position = 10
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_effect_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_effect, "configList", _configList)
	rawset(lua_auto_chess_effect, "configDict", _configDict)
end

setmetatable(lua_auto_chess_effect, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_effect.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_effect, "configList", nil)
	rawset(lua_auto_chess_effect, "configDict", nil)
end

return lua_auto_chess_effect
