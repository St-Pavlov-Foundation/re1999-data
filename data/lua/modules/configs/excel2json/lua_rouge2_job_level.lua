-- chunkname: @modules/configs/excel2json/lua_rouge2_job_level.lua

module("modules.configs.excel2json.lua_rouge2_job_level", package.seeall)

local lua_rouge2_job_level = {}
local fields = {
	geniusId = 2,
	talent = 1
}
local primaryKey = {
	"talent"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_job_level_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_job_level, "configList", _configList)
	rawset(lua_rouge2_job_level, "configDict", _configDict)
end

setmetatable(lua_rouge2_job_level, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_job_level.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_job_level, "configList", nil)
	rawset(lua_rouge2_job_level, "configDict", nil)
end

return lua_rouge2_job_level
