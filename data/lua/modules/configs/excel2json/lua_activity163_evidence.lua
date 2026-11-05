-- chunkname: @modules/configs/excel2json/lua_activity163_evidence.lua

module("modules.configs.excel2json.lua_activity163_evidence", package.seeall)

local lua_activity163_evidence = {}
local fields = {
	evidenceId = 1,
	showFusion = 7,
	tips = 6,
	errorTip = 5,
	conditionStr = 4,
	puzzleTxt = 3,
	dialogGroupType = 2
}
local primaryKey = {
	"evidenceId"
}
local mlStringKey = {
	conditionStr = 2,
	puzzleTxt = 1
}
local _configList, _configDict
local configPath = "configs.activity163_evidence_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity163_evidence, "configList", _configList)
	rawset(lua_activity163_evidence, "configDict", _configDict)
end

setmetatable(lua_activity163_evidence, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity163_evidence.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity163_evidence, "configList", nil)
	rawset(lua_activity163_evidence, "configDict", nil)
end

return lua_activity163_evidence
