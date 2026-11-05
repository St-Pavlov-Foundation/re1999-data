-- chunkname: @modules/configs/excel2json/lua_activity128_gallery.lua

module("modules.configs.excel2json.lua_activity128_gallery", package.seeall)

local lua_activity128_gallery = {}
local fields = {
	lurkNumber = 9,
	point = 6,
	typeName = 3,
	type = 1,
	pointExp = 7,
	galleryBg = 5,
	offline = 11,
	resource = 12,
	minType = 4,
	recommendStrategy = 8,
	id = 2,
	sort = 10
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	typeName = 1
}
local _configList, _configDict
local configPath = "configs.activity128_gallery_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity128_gallery, "configList", _configList)
	rawset(lua_activity128_gallery, "configDict", _configDict)
end

setmetatable(lua_activity128_gallery, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity128_gallery.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity128_gallery, "configList", nil)
	rawset(lua_activity128_gallery, "configDict", nil)
end

return lua_activity128_gallery
