-- chunkname: @modules/configs/excel2json/lua_editor_skill_tag.lua

module("modules.configs.excel2json.lua_editor_skill_tag", package.seeall)

local lua_editor_skill_tag = {}
local fields = {
	id = 1,
	name = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.editor_skill_tag_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_editor_skill_tag, "configList", _configList)
	rawset(lua_editor_skill_tag, "configDict", _configDict)
end

setmetatable(lua_editor_skill_tag, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_editor_skill_tag.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_editor_skill_tag, "configList", nil)
	rawset(lua_editor_skill_tag, "configDict", nil)
end

return lua_editor_skill_tag
