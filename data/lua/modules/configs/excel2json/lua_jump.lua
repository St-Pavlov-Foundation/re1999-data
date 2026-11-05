-- chunkname: @modules/configs/excel2json/lua_jump.lua

module("modules.configs.excel2json.lua_jump", package.seeall)

local lua_jump = {}
local fields = {
	id = 1,
	name = 2,
	param = 4,
	openId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	name = 1
}
local _configList, _configDict
local configPath = "configs.jump_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_jump, "configList", _configList)
	rawset(lua_jump, "configDict", _configDict)
end

setmetatable(lua_jump, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_jump.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_jump, "configList", nil)
	rawset(lua_jump, "configDict", nil)
end

return lua_jump
