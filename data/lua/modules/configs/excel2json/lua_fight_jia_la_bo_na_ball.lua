-- chunkname: @modules/configs/excel2json/lua_fight_jia_la_bo_na_ball.lua

module("modules.configs.excel2json.lua_fight_jia_la_bo_na_ball", package.seeall)

local lua_fight_jia_la_bo_na_ball = {}
local fields = {
	destroyBallEffect = 5,
	createBallEffect = 4,
	id = 1,
	buffTypeId = 2,
	ballEffect = 3
}
local primaryKey = {
	"id",
	"buffTypeId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.fight_jia_la_bo_na_ball_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_fight_jia_la_bo_na_ball, "configList", _configList)
	rawset(lua_fight_jia_la_bo_na_ball, "configDict", _configDict)
end

setmetatable(lua_fight_jia_la_bo_na_ball, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_fight_jia_la_bo_na_ball.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_fight_jia_la_bo_na_ball, "configList", nil)
	rawset(lua_fight_jia_la_bo_na_ball, "configDict", nil)
end

return lua_fight_jia_la_bo_na_ball
