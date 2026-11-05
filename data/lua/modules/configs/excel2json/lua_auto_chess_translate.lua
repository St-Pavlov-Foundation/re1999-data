-- chunkname: @modules/configs/excel2json/lua_auto_chess_translate.lua

module("modules.configs.excel2json.lua_auto_chess_translate", package.seeall)

local lua_auto_chess_translate = {}
local fields = {
	id = 1,
	name = 2,
	tagResName = 4,
	color = 3,
	isShow = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.auto_chess_translate_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_auto_chess_translate, "configList", _configList)
	rawset(lua_auto_chess_translate, "configDict", _configDict)
end

setmetatable(lua_auto_chess_translate, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_auto_chess_translate.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_auto_chess_translate, "configList", nil)
	rawset(lua_auto_chess_translate, "configDict", nil)
end

return lua_auto_chess_translate
