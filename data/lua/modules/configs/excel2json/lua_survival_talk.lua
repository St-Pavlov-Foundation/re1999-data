-- chunkname: @modules/configs/excel2json/lua_survival_talk.lua

module("modules.configs.excel2json.lua_survival_talk", package.seeall)

local lua_survival_talk = {}
local fields = {
	id = 1,
	animType = 4,
	content = 3,
	step = 2
}
local primaryKey = {
	"id",
	"step"
}
local mlStringKey = {
	content = 1
}
local _configList, _configDict
local configPath = "configs.survival_talk_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_talk, "configList", _configList)
	rawset(lua_survival_talk, "configDict", _configDict)
end

setmetatable(lua_survival_talk, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_talk.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_talk, "configList", nil)
	rawset(lua_survival_talk, "configDict", nil)
end

return lua_survival_talk
