-- chunkname: @modules/configs/excel2json/lua_rouge_surprise_attack.lua

module("modules.configs.excel2json.lua_rouge_surprise_attack", package.seeall)

local lua_rouge_surprise_attack = {}
local fields = {
	title = 2,
	hiddenRule = 4,
	ruleDesc = 5,
	tipsDesc = 6,
	id = 1,
	additionRule = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	tipsDesc = 3,
	title = 1,
	ruleDesc = 2
}
local _configList, _configDict
local configPath = "configs.rouge_surprise_attack_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_surprise_attack, "configList", _configList)
	rawset(lua_rouge_surprise_attack, "configDict", _configDict)
end

setmetatable(lua_rouge_surprise_attack, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_surprise_attack.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_surprise_attack, "configList", nil)
	rawset(lua_rouge_surprise_attack, "configDict", nil)
end

return lua_rouge_surprise_attack
