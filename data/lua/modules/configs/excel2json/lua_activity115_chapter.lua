-- chunkname: @modules/configs/excel2json/lua_activity115_chapter.lua

module("modules.configs.excel2json.lua_activity115_chapter", package.seeall)

local lua_activity115_chapter = {}
local fields = {
	id = 2,
	name = 3,
	ambientAudio = 6,
	name_En = 4,
	activityId = 1,
	openId = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity115_chapter_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity115_chapter, "configList", _configList)
	rawset(lua_activity115_chapter, "configDict", _configDict)
end

setmetatable(lua_activity115_chapter, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity115_chapter.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity115_chapter, "configList", nil)
	rawset(lua_activity115_chapter, "configDict", nil)
end

return lua_activity115_chapter
