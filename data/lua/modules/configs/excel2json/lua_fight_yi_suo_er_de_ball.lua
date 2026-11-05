-- chunkname: @modules/configs/excel2json/lua_fight_yi_suo_er_de_ball.lua

module("modules.configs.excel2json.lua_fight_yi_suo_er_de_ball", package.seeall)

local lua_fight_yi_suo_er_de_ball = {}
local fields = {
	id = 1,
	effect = 3,
	buffId = 2,
	audio = 4
}
local primaryKey = {
	"id",
	"buffId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_yi_suo_er_de_ball_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_yi_suo_er_de_ball, "configList", _configList)
	rawset(lua_fight_yi_suo_er_de_ball, "configDict", _configDict)
end

setmetatable(lua_fight_yi_suo_er_de_ball, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_yi_suo_er_de_ball.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_yi_suo_er_de_ball, "configList", nil)
	rawset(lua_fight_yi_suo_er_de_ball, "configDict", nil)
end

return lua_fight_yi_suo_er_de_ball
