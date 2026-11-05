-- chunkname: @modules/configs/excel2json/lua_assassin_style_zongmao.lua

module("modules.configs.excel2json.lua_assassin_style_zongmao", package.seeall)

local lua_assassin_style_zongmao = {}
local fields = {
	itemId = 1,
	number = 2
}
local primaryKey = {
	"itemId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assassin_style_zongmao_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assassin_style_zongmao, "configList", _configList)
	rawset(lua_assassin_style_zongmao, "configDict", _configDict)
end

setmetatable(lua_assassin_style_zongmao, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assassin_style_zongmao.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assassin_style_zongmao, "configList", nil)
	rawset(lua_assassin_style_zongmao, "configDict", nil)
end

return lua_assassin_style_zongmao
