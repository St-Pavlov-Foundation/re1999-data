-- chunkname: @modules/configs/excel2json/lua_turnback_task_bonus.lua

module("modules.configs.excel2json.lua_turnback_task_bonus", package.seeall)

local lua_turnback_task_bonus = {}
local fields = {
	character = 5,
	needPoint = 7,
	extraBonus = 4,
	id = 2,
	turnbackId = 1,
	content = 6,
	bonus = 3
}
local primaryKey = {
	"turnbackId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_task_bonus_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_task_bonus, "configList", _configList)
	rawset(lua_turnback_task_bonus, "configDict", _configDict)
end

setmetatable(lua_turnback_task_bonus, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_task_bonus.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_task_bonus, "configList", nil)
	rawset(lua_turnback_task_bonus, "configDict", nil)
end

return lua_turnback_task_bonus
