-- chunkname: @modules/configs/excel2json/lua_activity166_info_analy.lua

module("modules.configs.excel2json.lua_activity166_info_analy", package.seeall)

local lua_activity166_info_analy = {}
local fields = {
	content = 6,
	infoId = 2,
	consume = 4,
	stage = 3,
	activityId = 1,
	bonus = 5
}
local primaryKey = {
	"activityId",
	"infoId",
	"stage"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.activity166_info_analy_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_info_analy, "configList", _configList)
	rawset(lua_activity166_info_analy, "configDict", _configDict)
end

setmetatable(lua_activity166_info_analy, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_info_analy.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_info_analy, "configList", nil)
	rawset(lua_activity166_info_analy, "configDict", nil)
end

return lua_activity166_info_analy
