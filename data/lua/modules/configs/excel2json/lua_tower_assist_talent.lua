-- chunkname: @modules/configs/excel2json/lua_tower_assist_talent.lua

module("modules.configs.excel2json.lua_tower_assist_talent", package.seeall)

local lua_tower_assist_talent = {}
local fields = {
	bossId = 1,
	nodeId = 2,
	startNode = 4,
	nodeType = 12,
	extraRule = 9,
	nodeName = 13,
	nodeGroup = 8,
	nodeDesc = 14,
	isBigNode = 11,
	consume = 5,
	heroPassiveSkills = 7,
	position = 10,
	preNodeIds = 3,
	bossPassiveSkills = 6
}
local primaryKey = {
	"bossId",
	"nodeId"
}
local mlStringKey = {
	nodeName = 1,
	nodeDesc = 2
}
local _configList, _configDict
local configPath = "configs.tower_assist_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_tower_assist_talent, "configList", _configList)
	rawset(lua_tower_assist_talent, "configDict", _configDict)
end

setmetatable(lua_tower_assist_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_tower_assist_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_tower_assist_talent, "configList", nil)
	rawset(lua_tower_assist_talent, "configDict", nil)
end

return lua_tower_assist_talent
