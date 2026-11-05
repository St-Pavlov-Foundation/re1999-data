-- chunkname: @modules/configs/excel2json/lua_assist_boss_stance.lua

module("modules.configs.excel2json.lua_assist_boss_stance", package.seeall)

local lua_assist_boss_stance = {}
local fields = {
	sceneId = 2,
	position = 3,
	scale = 4,
	skinId = 1
}
local primaryKey = {
	"skinId",
	"sceneId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.assist_boss_stance_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_assist_boss_stance, "configList", _configList)
	rawset(lua_assist_boss_stance, "configDict", _configDict)
end

setmetatable(lua_assist_boss_stance, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_assist_boss_stance.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_assist_boss_stance, "configList", nil)
	rawset(lua_assist_boss_stance, "configDict", nil)
end

return lua_assist_boss_stance
