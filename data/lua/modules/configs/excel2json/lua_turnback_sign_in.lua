-- chunkname: @modules/configs/excel2json/lua_turnback_sign_in.lua

module("modules.configs.excel2json.lua_turnback_sign_in", package.seeall)

local lua_turnback_sign_in = {}
local fields = {
	bonus = 3,
	name = 5,
	characterId = 4,
	turnbackId = 1,
	content = 6,
	day = 2
}
local primaryKey = {
	"turnbackId",
	"day"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_sign_in_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_sign_in, "configList", _configList)
	rawset(lua_turnback_sign_in, "configDict", _configDict)
end

setmetatable(lua_turnback_sign_in, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_sign_in.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_sign_in, "configList", nil)
	rawset(lua_turnback_sign_in, "configDict", nil)
end

return lua_turnback_sign_in
