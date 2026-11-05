-- chunkname: @modules/configs/excel2json/lua_skin_spine_action.lua

module("modules.configs.excel2json.lua_skin_spine_action", package.seeall)

local lua_skin_spine_action = {}
local fields = {
	effectForSub = 8,
	effect = 3,
	effectRemoveTime = 5,
	dieAnim = 7,
	skinId = 1,
	effectHandPointForSub = 9,
	effectRemoveTimeForSub = 10,
	audioId = 6,
	audioIdForSub = 11,
	effectHangPoint = 4,
	actionName = 2
}
local primaryKey = {
	"skinId",
	"actionName"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_spine_action_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_spine_action, "configList", _configList)
	rawset(lua_skin_spine_action, "configDict", _configDict)
end

setmetatable(lua_skin_spine_action, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_spine_action.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_spine_action, "configList", nil)
	rawset(lua_skin_spine_action, "configDict", nil)
end

return lua_skin_spine_action
