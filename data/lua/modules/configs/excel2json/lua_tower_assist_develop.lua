-- chunkname: @modules/configs/excel2json/lua_tower_assist_develop.lua

module("modules.configs.excel2json.lua_tower_assist_develop", package.seeall)

local lua_tower_assist_develop = {}
local fields = {
	bossId = 1,
	passiveSkills = 5,
	talentPoint = 4,
	attribute = 3,
	extraRule = 6,
	level = 2
}
local primaryKey = {
	"bossId",
	"level"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.tower_assist_develop_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_assist_develop, "configList", _configList)
	rawset(lua_tower_assist_develop, "configDict", _configDict)
end

setmetatable(lua_tower_assist_develop, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_assist_develop.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_assist_develop, "configList", nil)
	rawset(lua_tower_assist_develop, "configDict", nil)
end

return lua_tower_assist_develop
