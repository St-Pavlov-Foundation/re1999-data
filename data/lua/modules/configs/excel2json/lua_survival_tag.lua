-- chunkname: @modules/configs/excel2json/lua_survival_tag.lua

module("modules.configs.excel2json.lua_survival_tag", package.seeall)

local lua_survival_tag = {}
local fields = {
	tagType = 5,
	name = 2,
	effect = 6,
	color = 7,
	id = 1,
	suggestMap = 8,
	beHidden = 4,
	desc = 3
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	desc = 2,
	name = 1
}
local _configList, _configDict
local configPath = "configs.survival_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_survival_tag, "configList", _configList)
	rawset(lua_survival_tag, "configDict", _configDict)
end

setmetatable(lua_survival_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_survival_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_survival_tag, "configList", nil)
	rawset(lua_survival_tag, "configDict", nil)
end

return lua_survival_tag
