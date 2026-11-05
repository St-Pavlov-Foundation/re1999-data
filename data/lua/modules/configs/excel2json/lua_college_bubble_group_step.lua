-- chunkname: @modules/configs/excel2json/lua_college_bubble_group_step.lua

module("modules.configs.excel2json.lua_college_bubble_group_step", package.seeall)

local lua_college_bubble_group_step = {}
local fields = {
	text = 4,
	name = 3,
	position = 7,
	chessPosition = 8,
	groupId = 1,
	actorId = 5,
	pos = 6,
	step = 2
}
local primaryKey = {
	"groupId",
	"step"
}
local mlStringKey = {
	text = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.college_bubble_group_step_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_bubble_group_step, "configList", _configList)
	rawset(lua_college_bubble_group_step, "configDict", _configDict)
end

setmetatable(lua_college_bubble_group_step, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_bubble_group_step.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_bubble_group_step, "configList", nil)
	rawset(lua_college_bubble_group_step, "configDict", nil)
end

return lua_college_bubble_group_step
