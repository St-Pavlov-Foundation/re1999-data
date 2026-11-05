-- chunkname: @modules/configs/excel2json/lua_help_video.lua

module("modules.configs.excel2json.lua_help_video", package.seeall)

local lua_help_video = {}
local fields = {
	text = 4,
	videopath = 2,
	storyId = 6,
	type = 3,
	id = 1,
	icon = 5,
	unlockGuideId = 7
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.help_video_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_help_video, "configList", _configList)
	rawset(lua_help_video, "configDict", _configDict)
end

setmetatable(lua_help_video, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_help_video.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_help_video, "configList", nil)
	rawset(lua_help_video, "configDict", nil)
end

return lua_help_video
