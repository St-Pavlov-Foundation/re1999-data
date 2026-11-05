-- chunkname: @modules/configs/excel2json/lua_rouge_collection_unlock.lua

module("modules.configs.excel2json.lua_rouge_collection_unlock", package.seeall)

local lua_rouge_collection_unlock = {}
local fields = {
	typeSort = 3,
	unlockType = 5,
	sortId = 2,
	rareSort = 4,
	id = 1,
	unlockParam = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_collection_unlock_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_collection_unlock, "configList", _configList)
	rawset(lua_rouge_collection_unlock, "configDict", _configDict)
end

setmetatable(lua_rouge_collection_unlock, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_collection_unlock.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_collection_unlock, "configList", nil)
	rawset(lua_rouge_collection_unlock, "configDict", nil)
end

return lua_rouge_collection_unlock
