-- chunkname: @modules/configs/excel2json/lua_college_stage.lua

module("modules.configs.excel2json.lua_college_stage", package.seeall)

local lua_college_stage = {}
local fields = {
	id = 1,
	title = 2,
	nextStageId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title = 1
}
local _configList, _configDict
local configPath = "configs.college_stage_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_stage, "configList", _configList)
	rawset(lua_college_stage, "configDict", _configDict)
end

setmetatable(lua_college_stage, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_stage.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_stage, "configList", nil)
	rawset(lua_college_stage, "configDict", nil)
end

return lua_college_stage
