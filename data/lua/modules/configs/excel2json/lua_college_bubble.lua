-- chunkname: @modules/configs/excel2json/lua_college_bubble.lua

module("modules.configs.excel2json.lua_college_bubble", package.seeall)

local lua_college_bubble = {}
local fields = {
	text = 4,
	buildingId = 2,
	dailyPlayOnce = 6,
	id = 1,
	actorId = 3,
	weight = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	text = 1
}
local _configList, _configDict
local configPath = "configs.college_bubble_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_college_bubble, "configList", _configList)
	rawset(lua_college_bubble, "configDict", _configDict)
end

setmetatable(lua_college_bubble, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_college_bubble.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_college_bubble, "configList", nil)
	rawset(lua_college_bubble, "configDict", nil)
end

return lua_college_bubble
