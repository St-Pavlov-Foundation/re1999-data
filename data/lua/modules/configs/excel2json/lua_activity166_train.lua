-- chunkname: @modules/configs/excel2json/lua_activity166_train.lua

module("modules.configs.excel2json.lua_activity166_train", package.seeall)

local lua_activity166_train = {}
local fields = {
	trainId = 2,
	name = 7,
	winDesc = 12,
	needStar = 4,
	strategy = 11,
	firstBonus = 6,
	level = 10,
	episodeId = 3,
	desc = 9,
	type = 5,
	activityId = 1,
	nameEn = 8
}
local primaryKey = {
	"activityId",
	"trainId"
}
local mlStringKey = {
	strategy = 3,
	name = 1,
	winDesc = 4,
	desc = 2
}
local _configList, _configDict
local configPath = "configs.activity166_train_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_activity166_train, "configList", _configList)
	rawset(lua_activity166_train, "configDict", _configDict)
end

setmetatable(lua_activity166_train, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_activity166_train.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_activity166_train, "configList", nil)
	rawset(lua_activity166_train, "configDict", nil)
end

return lua_activity166_train
