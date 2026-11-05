-- chunkname: @modules/configs/excel2json/lua_odyssey_talent.lua

module("modules.configs.excel2json.lua_odyssey_talent", package.seeall)

local lua_odyssey_talent = {}
local fields = {
	position = 11,
	nodeId = 1,
	nodeName = 6,
	type = 5,
	unlockCondition = 4,
	addRule = 10,
	nodeDesc = 7,
	consume = 3,
	addSkill = 9,
	icon = 8,
	level = 2
}
local primaryKey = {
	"nodeId",
	"level"
}
local mlStringKey = {
	nodeName = 1,
	nodeDesc = 2
}
local _configList, _configDict
local configPath = "configs.odyssey_talent_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_odyssey_talent, "configList", _configList)
	rawset(lua_odyssey_talent, "configDict", _configDict)
end

setmetatable(lua_odyssey_talent, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_odyssey_talent.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_odyssey_talent, "configList", nil)
	rawset(lua_odyssey_talent, "configDict", nil)
end

return lua_odyssey_talent
