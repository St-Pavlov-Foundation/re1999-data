-- chunkname: @modules/configs/excel2json/lua_bp_skin_view_param.lua

module("modules.configs.excel2json.lua_bp_skin_view_param", package.seeall)

local lua_bp_skin_view_param = {}
local fields = {
	audioId = 2,
	storePrefab = 3,
	closeAudioId = 5,
	skinId = 1,
	online = 6,
	openAudioId = 4
}
local primaryKey = {
	"skinId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.bp_skin_view_param_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_bp_skin_view_param, "configList", _configList)
	rawset(lua_bp_skin_view_param, "configDict", _configDict)
end

setmetatable(lua_bp_skin_view_param, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_bp_skin_view_param.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_bp_skin_view_param, "configList", nil)
	rawset(lua_bp_skin_view_param, "configDict", nil)
end

return lua_bp_skin_view_param
