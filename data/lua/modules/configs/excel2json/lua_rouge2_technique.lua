-- chunkname: @modules/configs/excel2json/lua_rouge2_technique.lua

module("modules.configs.excel2json.lua_rouge2_technique", package.seeall)

local lua_rouge2_technique = {}
local fields = {
	mainTitleId = 2,
	picture = 6,
	subTitle = 5,
	pos = 8,
	id = 1,
	mainTitle = 4,
	content = 7,
	subTitleId = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	content = 3,
	mainTitle = 1,
	subTitle = 2
}
local _configList, _configDict
local configPath = "configs.rouge2_technique_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_rouge2_technique, "configList", _configList)
	rawset(lua_rouge2_technique, "configDict", _configDict)
end

setmetatable(lua_rouge2_technique, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_rouge2_technique.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_rouge2_technique, "configList", nil)
	rawset(lua_rouge2_technique, "configDict", nil)
end

return lua_rouge2_technique
