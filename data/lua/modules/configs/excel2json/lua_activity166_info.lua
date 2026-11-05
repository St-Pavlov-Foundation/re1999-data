-- chunkname: @modules/configs/excel2json/lua_activity166_info.lua

module("modules.configs.excel2json.lua_activity166_info", package.seeall)

local lua_activity166_info = {}
local fields = {
	initContent = 10,
	name = 6,
	reportRes = 8,
	unlockParam = 4,
	infoId = 2,
	reportPic = 9,
	unlockType = 3,
	unlockDes = 5,
	activityId = 1,
	nameEn = 7
}
local primaryKey = {
	"activityId",
	"infoId"
}
local mlStringKey = {
	initContent = 3,
	name = 2,
	unlockDes = 1
}
local _configList, _configDict
local configPath = "configs.activity166_info_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_info, "configList", _configList)
	rawset(lua_activity166_info, "configDict", _configDict)
end

setmetatable(lua_activity166_info, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_info.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_info, "configList", nil)
	rawset(lua_activity166_info, "configDict", nil)
end

return lua_activity166_info
