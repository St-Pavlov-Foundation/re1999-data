-- chunkname: @modules/configs/excel2json/lua_activity225_npc.lua

module("modules.configs.excel2json.lua_activity225_npc", package.seeall)

local lua_activity225_npc = {}
local fields = {
	npcType = 3,
	npcName = 5,
	titleId = 6,
	skinId = 7,
	weight = 9,
	interactiveId = 8,
	eggTxt = 11,
	keepTime = 10,
	npcId = 2,
	npcRace = 4,
	activityId = 1
}
local primaryKey = {
	"activityId",
	"npcId"
}
local mlStringKey = {
	eggTxt = 2,
	npcName = 1
}
local _configList, _configDict
local configPath = "configs.activity225_npc_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity225_npc, "configList", _configList)
	rawset(lua_activity225_npc, "configDict", _configDict)
end

setmetatable(lua_activity225_npc, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity225_npc.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity225_npc, "configList", nil)
	rawset(lua_activity225_npc, "configDict", nil)
end

return lua_activity225_npc
