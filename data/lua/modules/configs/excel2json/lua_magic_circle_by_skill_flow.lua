-- chunkname: @modules/configs/excel2json/lua_magic_circle_by_skill_flow.lua

module("modules.configs.excel2json.lua_magic_circle_by_skill_flow", package.seeall)

local lua_magic_circle_by_skill_flow = {}
local fields = {
	closeEffect = 6,
	enterTime = 3,
	posArr = 9,
	closeTime = 7,
	enterEffect = 2,
	enterAudio = 4,
	loopEffect = 5,
	id = 1,
	closeAudio = 8
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.magic_circle_by_skill_flow_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_magic_circle_by_skill_flow, "configList", _configList)
	rawset(lua_magic_circle_by_skill_flow, "configDict", _configDict)
end

setmetatable(lua_magic_circle_by_skill_flow, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_magic_circle_by_skill_flow.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_magic_circle_by_skill_flow, "configList", nil)
	rawset(lua_magic_circle_by_skill_flow, "configDict", nil)
end

return lua_magic_circle_by_skill_flow
