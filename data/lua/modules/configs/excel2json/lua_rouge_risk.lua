-- chunkname: @modules/configs/excel2json/lua_rouge_risk.lua

module("modules.configs.excel2json.lua_rouge_risk", package.seeall)

local lua_rouge_risk = {}
local fields = {
	buffNum = 7,
	range = 4,
	scoreReward = 8,
	title = 2,
	content = 6,
	desc = 5,
	title_en = 3,
	id = 1,
	viewDown = 10,
	attr = 9
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	title_en = 2,
	title = 1,
	content = 4,
	desc = 3
}
local _configList, _configDict
local configPath = "configs.rouge_risk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_risk, "configList", _configList)
	rawset(lua_rouge_risk, "configDict", _configDict)
end

setmetatable(lua_rouge_risk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_risk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_risk, "configList", nil)
	rawset(lua_rouge_risk, "configDict", nil)
end

return lua_rouge_risk
