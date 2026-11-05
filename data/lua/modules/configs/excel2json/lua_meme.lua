-- chunkname: @modules/configs/excel2json/lua_meme.lua

module("modules.configs.excel2json.lua_meme", package.seeall)

local lua_meme = {}
local fields = {
	id = 1,
	name = 2,
	icon = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.meme_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_meme, "configList", _configList)
	rawset(lua_meme, "configDict", _configDict)
end

setmetatable(lua_meme, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_meme.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_meme, "configList", nil)
	rawset(lua_meme, "configDict", nil)
end

return lua_meme
