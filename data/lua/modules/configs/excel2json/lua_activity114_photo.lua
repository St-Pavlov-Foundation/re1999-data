-- chunkname: @modules/configs/excel2json/lua_activity114_photo.lua

module("modules.configs.excel2json.lua_activity114_photo", package.seeall)

local lua_activity114_photo = {}
local fields = {
	name = 4,
	bigCg = 7,
	condition = 3,
	desc = 9,
	smallCg = 6,
	id = 2,
	features = 8,
	activityId = 1,
	nameEn = 5
}
local primaryKey = {
	"activityId",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.activity114_photo_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity114_photo, "configList", _configList)
	rawset(lua_activity114_photo, "configDict", _configDict)
end

setmetatable(lua_activity114_photo, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity114_photo.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity114_photo, "configList", nil)
	rawset(lua_activity114_photo, "configDict", nil)
end

return lua_activity114_photo
