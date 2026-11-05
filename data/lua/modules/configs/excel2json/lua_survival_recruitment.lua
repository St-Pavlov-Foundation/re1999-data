-- chunkname: @modules/configs/excel2json/lua_survival_recruitment.lua

module("modules.configs.excel2json.lua_survival_recruitment", package.seeall)

local lua_survival_recruitment = {}
local fields = {
	id = 1,
	conditionType = 3,
	param = 4,
	desc = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 1
}
local _configList, _configDict
local configPath = "configs.survival_recruitment_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_recruitment, "configList", _configList)
	rawset(lua_survival_recruitment, "configDict", _configDict)
end

setmetatable(lua_survival_recruitment, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_recruitment.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_recruitment, "configList", nil)
	rawset(lua_survival_recruitment, "configDict", nil)
end

return lua_survival_recruitment
