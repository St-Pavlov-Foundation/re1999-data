-- chunkname: @modules/configs/excel2json/lua_rouge_displace.lua

module("modules.configs.excel2json.lua_rouge_displace", package.seeall)

local lua_rouge_displace = {}
local fields = {
	season = 1,
	quality = 3,
	id = 2,
	upDropGroup = 5,
	dropGroup = 4
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_displace_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_displace, "configList", _configList)
	rawset(lua_rouge_displace, "configDict", _configDict)
end

setmetatable(lua_rouge_displace, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_displace.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_displace, "configList", nil)
	rawset(lua_rouge_displace, "configDict", nil)
end

return lua_rouge_displace
