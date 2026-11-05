-- chunkname: @modules/configs/excel2json/lua_college_actor.lua

module("modules.configs.excel2json.lua_college_actor", package.seeall)

local lua_college_actor = {}
local fields = {
	name = 2,
	rarity = 4,
	avatar = 5,
	type = 3,
	id = 1,
	pieceAsset = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.college_actor_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_actor, "configList", _configList)
	rawset(lua_college_actor, "configDict", _configDict)
end

setmetatable(lua_college_actor, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_actor.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_actor, "configList", nil)
	rawset(lua_college_actor, "configDict", nil)
end

return lua_college_actor
