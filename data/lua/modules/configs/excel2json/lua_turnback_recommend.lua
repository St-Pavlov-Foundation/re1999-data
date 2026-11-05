-- chunkname: @modules/configs/excel2json/lua_turnback_recommend.lua

module("modules.configs.excel2json.lua_turnback_recommend", package.seeall)

local lua_turnback_recommend = {}
local fields = {
	jumpId = 10,
	limitCount = 12,
	turnbackId = 1,
	relateActId = 11,
	prepose = 5,
	offlineTime = 8,
	constTime = 6,
	openId = 9,
	onlineTime = 7,
	id = 2,
	icon = 3,
	order = 4
}
local primaryKey = {
	"turnbackId",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.turnback_recommend_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_turnback_recommend, "configList", _configList)
	rawset(lua_turnback_recommend, "configDict", _configDict)
end

setmetatable(lua_turnback_recommend, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_turnback_recommend.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_turnback_recommend, "configList", nil)
	rawset(lua_turnback_recommend, "configDict", nil)
end

return lua_turnback_recommend
