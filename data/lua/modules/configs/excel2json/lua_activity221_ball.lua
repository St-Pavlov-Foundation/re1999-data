-- chunkname: @modules/configs/excel2json/lua_activity221_ball.lua

module("modules.configs.excel2json.lua_activity221_ball", package.seeall)

local lua_activity221_ball = {}
local fields = {
	skillIds = 2,
	image = 4,
	action = 3,
	ballType = 1
}
local primaryKey = {
	"ballType"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.activity221_ball_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity221_ball, "configList", _configList)
	rawset(lua_activity221_ball, "configDict", _configDict)
end

setmetatable(lua_activity221_ball, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity221_ball.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity221_ball, "configList", nil)
	rawset(lua_activity221_ball, "configDict", nil)
end

return lua_activity221_ball
