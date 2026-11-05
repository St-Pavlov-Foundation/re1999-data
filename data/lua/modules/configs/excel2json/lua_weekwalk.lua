-- chunkname: @modules/configs/excel2json/lua_weekwalk.lua

module("modules.configs.excel2json.lua_weekwalk", package.seeall)

local lua_weekwalk = {}
local fields = {
	notCdHeroCount = 5,
	resIdRear = 11,
	preId = 3,
	type = 4,
	fightIdFront = 8,
	sceneId = 6,
	issueId = 7,
	resIdFront = 9,
	id = 1,
	fightIdRear = 10,
	layer = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.weekwalk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_weekwalk, "configList", _configList)
	rawset(lua_weekwalk, "configDict", _configDict)
end

setmetatable(lua_weekwalk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_weekwalk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_weekwalk, "configList", nil)
	rawset(lua_weekwalk, "configDict", nil)
end

return lua_weekwalk
