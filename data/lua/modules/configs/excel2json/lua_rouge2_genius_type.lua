-- chunkname: @modules/configs/excel2json/lua_rouge2_genius_type.lua

module("modules.configs.excel2json.lua_rouge2_genius_type", package.seeall)

local lua_rouge2_genius_type = {}
local fields = {
	pointCost = 4,
	talent = 1,
	geniusId = 2,
	careerExp = 3,
	order = 5
}
local primaryKey = {
	"talent",
	"geniusId"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.rouge2_genius_type_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_genius_type, "configList", _configList)
	rawset(lua_rouge2_genius_type, "configDict", _configDict)
end

setmetatable(lua_rouge2_genius_type, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_genius_type.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_genius_type, "configList", nil)
	rawset(lua_rouge2_genius_type, "configDict", nil)
end

return lua_rouge2_genius_type
