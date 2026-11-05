-- chunkname: @modules/configs/excel2json/lua_skin_special_act.lua

module("modules.configs.excel2json.lua_skin_special_act", package.seeall)

local lua_skin_special_act = {}
local fields = {
	loop = 2,
	probability = 4,
	condition = 3,
	id = 1
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.skin_special_act_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_skin_special_act, "configList", _configList)
	rawset(lua_skin_special_act, "configDict", _configDict)
end

setmetatable(lua_skin_special_act, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_skin_special_act.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_skin_special_act, "configList", nil)
	rawset(lua_skin_special_act, "configDict", nil)
end

return lua_skin_special_act
