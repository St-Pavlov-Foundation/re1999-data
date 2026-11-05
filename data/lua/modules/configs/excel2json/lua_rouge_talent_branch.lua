-- chunkname: @modules/configs/excel2json/lua_rouge_talent_branch.lua

module("modules.configs.excel2json.lua_rouge_talent_branch", package.seeall)

local lua_rouge_talent_branch = {}
local fields = {
	cost = 8,
	name = 3,
	isOrigin = 9,
	before = 4,
	pos = 5,
	desc = 10,
	talent = 2,
	special = 7,
	id = 1,
	icon = 11,
	attribute = 6
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.rouge_talent_branch_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_talent_branch, "configList", _configList)
	rawset(lua_rouge_talent_branch, "configDict", _configDict)
end

setmetatable(lua_rouge_talent_branch, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_talent_branch.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_talent_branch, "configList", nil)
	rawset(lua_rouge_talent_branch, "configDict", nil)
end

return lua_rouge_talent_branch
