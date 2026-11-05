-- chunkname: @modules/configs/excel2json/lua_login_view_page.lua

module("modules.configs.excel2json.lua_login_view_page", package.seeall)

local lua_login_view_page = {}
local fields = {
	audioId = 6,
	prefab = 3,
	id = 1,
	stopAudioId = 7,
	bgimage = 4,
	name = 2,
	video = 5,
	episodeId = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.login_view_page_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_login_view_page, "configList", _configList)
	rawset(lua_login_view_page, "configDict", _configDict)
end

setmetatable(lua_login_view_page, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_login_view_page.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_login_view_page, "configList", nil)
	rawset(lua_login_view_page, "configDict", nil)
end

return lua_login_view_page
