-- chunkname: @modules/configs/excel2json/lua_atomic_anime.lua

module("modules.configs.excel2json.lua_atomic_anime", package.seeall)

local lua_atomic_anime = {}
local fields = {
	name = 3,
	res = 4,
	levelid = 2,
	video = 5,
	isloop = 6,
	place = 7,
	animeid = 1
}
local primaryKey = {
	"animeid"
}
local mlStringKey = {
	place = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.atomic_anime_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_atomic_anime, "configList", _configList)
	rawset(lua_atomic_anime, "configDict", _configDict)
end

setmetatable(lua_atomic_anime, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_atomic_anime.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_atomic_anime, "configList", nil)
	rawset(lua_atomic_anime, "configDict", nil)
end

return lua_atomic_anime
