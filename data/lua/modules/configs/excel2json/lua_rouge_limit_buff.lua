-- chunkname: @modules/configs/excel2json/lua_rouge_limit_buff.lua

module("modules.configs.excel2json.lua_rouge_limit_buff", package.seeall)

local lua_rouge_limit_buff = {}
local fields = {
	needEmblem = 8,
	buffType = 5,
	cd = 9,
	startView = 6,
	blank = 10,
	title = 3,
	icon = 11,
	desc = 4,
	initCollections = 7,
	id = 1,
	version = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	title = 1
}
local _configList, _configDict
local configPath = "configs.rouge_limit_buff_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_limit_buff, "configList", _configList)
	rawset(lua_rouge_limit_buff, "configDict", _configDict)
end

setmetatable(lua_rouge_limit_buff, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_limit_buff.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_limit_buff, "configList", nil)
	rawset(lua_rouge_limit_buff, "configDict", nil)
end

return lua_rouge_limit_buff
