-- chunkname: @modules/configs/excel2json/lua_weekwalk_ver2.lua

module("modules.configs.excel2json.lua_weekwalk_ver2", package.seeall)

local lua_weekwalk_ver2 = {}
local fields = {
	chooseSkillNum = 10,
	resIdRear = 9,
	preId = 4,
	fightIdFront = 6,
	sceneId = 5,
	issueId = 3,
	resIdFront = 7,
	id = 1,
	fightIdRear = 8,
	layer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_ver2_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk_ver2, "configList", _configList)
	rawset(lua_weekwalk_ver2, "configDict", _configDict)
end

setmetatable(lua_weekwalk_ver2, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk_ver2.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk_ver2, "configList", nil)
	rawset(lua_weekwalk_ver2, "configDict", nil)
end

return lua_weekwalk_ver2
