-- chunkname: @modules/configs/excel2json/lua_video_lang.lua

module("modules.configs.excel2json.lua_video_lang", package.seeall)

local lua_video_lang = {}
local fields = {
	supportLang = 2,
	name = 1
}
local primaryKey = {
	"name"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.video_lang_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_video_lang, "configList", _configList)
	rawset(lua_video_lang, "configDict", _configDict)
end

setmetatable(lua_video_lang, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_video_lang.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_video_lang, "configList", nil)
	rawset(lua_video_lang, "configDict", nil)
end

return lua_video_lang
