-- chunkname: @modules/configs/excel2json/lua_rouge_genius_branchlight.lua

module("modules.configs.excel2json.lua_rouge_genius_branchlight", package.seeall)

local lua_rouge_genius_branchlight = {}
local fields = {
	lightname = 3,
	talent = 2,
	id = 1,
	pos = 4,
	order = 5
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge_genius_branchlight_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge_genius_branchlight, "configList", _configList)
	rawset(lua_rouge_genius_branchlight, "configDict", _configDict)
end

setmetatable(lua_rouge_genius_branchlight, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge_genius_branchlight.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge_genius_branchlight, "configList", nil)
	rawset(lua_rouge_genius_branchlight, "configDict", nil)
end

return lua_rouge_genius_branchlight
