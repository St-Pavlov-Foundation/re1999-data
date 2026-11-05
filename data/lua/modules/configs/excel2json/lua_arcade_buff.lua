-- chunkname: @modules/configs/excel2json/lua_arcade_buff.lua

module("modules.configs.excel2json.lua_arcade_buff", package.seeall)

local lua_arcade_buff = {}
local fields = {
	showPriority = 8,
	entityType = 5,
	addPassiveSkillId = 4,
	round = 6,
	effectName = 2,
	loopEffect = 10,
	gainEffect = 9,
	id = 1,
	notSubInRoundBegin = 7,
	effectParam = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.arcade_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_arcade_buff, "configList", _configList)
	rawset(lua_arcade_buff, "configDict", _configDict)
end

setmetatable(lua_arcade_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_arcade_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_arcade_buff, "configList", nil)
	rawset(lua_arcade_buff, "configDict", nil)
end

return lua_arcade_buff
