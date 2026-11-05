-- chunkname: @modules/configs/excel2json/lua_actvity186_like.lua

module("modules.configs.excel2json.lua_actvity186_like", package.seeall)

local lua_actvity186_like = {}
local fields = {
	nameen = 4,
	name = 3,
	basevalueornot = 6,
	type = 1,
	icon = 5,
	activityId = 2
}
local primaryKey = {
	"type"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.actvity186_like_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_actvity186_like, "configList", _configList)
	rawset(lua_actvity186_like, "configDict", _configDict)
end

setmetatable(lua_actvity186_like, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_actvity186_like.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_actvity186_like, "configList", nil)
	rawset(lua_actvity186_like, "configDict", nil)
end

return lua_actvity186_like
