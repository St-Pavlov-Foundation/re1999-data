-- chunkname: @modules/configs/excel2json/lua_rouge_genius_branch.lua

module("modules.configs.excel2json.lua_rouge_genius_branch", package.seeall)

local lua_rouge_genius_branch = {}
local fields = {
	cost = 11,
	openDesc = 8,
	isOrigin = 14,
	startView = 13,
	season = 1,
	show = 12,
	pos = 6,
	desc = 15,
	effects = 9,
	talent = 3,
	initialCollection = 10,
	name = 4,
	id = 2,
	icon = 16,
	before = 5,
	attribute = 7
}
local primaryKey = {
	"season",
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_genius_branch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_genius_branch, "configList", _configList)
	rawset(lua_rouge_genius_branch, "configDict", _configDict)
end

setmetatable(lua_rouge_genius_branch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_genius_branch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_genius_branch, "configList", nil)
	rawset(lua_rouge_genius_branch, "configDict", nil)
end

return lua_rouge_genius_branch
