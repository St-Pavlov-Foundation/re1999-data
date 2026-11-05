-- chunkname: @modules/configs/excel2json/lua_block_task.lua

module("modules.configs.excel2json.lua_block_task", package.seeall)

local lua_block_task = {}
local fields = {
	order = 4,
	isGuide = 5,
	id = 1,
	resourceId = 2,
	taskType = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.block_task_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_block_task, "configList", _configList)
	rawset(lua_block_task, "configDict", _configDict)
end

setmetatable(lua_block_task, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block_task.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block_task, "configList", nil)
	rawset(lua_block_task, "configDict", nil)
end

return lua_block_task
