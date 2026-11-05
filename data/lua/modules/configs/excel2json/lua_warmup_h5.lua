-- chunkname: @modules/configs/excel2json/lua_warmup_h5.lua

module("modules.configs.excel2json.lua_warmup_h5", package.seeall)

local lua_warmup_h5 = {}
local fields = {
	activityId = 1,
	overseaSwitch = 4,
	link = 2,
	bgResUrl = 3
}
local primaryKey = {
	"activityId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.warmup_h5_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_warmup_h5, "configList", _configList)
	rawset(lua_warmup_h5, "configDict", _configDict)
end

setmetatable(lua_warmup_h5, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_warmup_h5.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_warmup_h5, "configList", nil)
	rawset(lua_warmup_h5, "configDict", nil)
end

return lua_warmup_h5
