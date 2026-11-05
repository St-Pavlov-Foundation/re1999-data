-- chunkname: @modules/configs/excel2json/lua_copost_password_paper.lua

module("modules.configs.excel2json.lua_copost_password_paper", package.seeall)

local lua_copost_password_paper = {}
local fields = {
	id = 1,
	diskText = 5,
	item = 7,
	order = 6,
	allNum = 3,
	diskIcon = 4,
	viewType = 8,
	versionId = 2
}
local primaryKey = {
	"id"
}
local mlStringKey = {
	diskText = 1
}
local _configList, _configDict
local configPath = "configs.copost_password_paper_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_copost_password_paper, "configList", _configList)
	rawset(lua_copost_password_paper, "configDict", _configDict)
end

setmetatable(lua_copost_password_paper, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_copost_password_paper.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_copost_password_paper, "configList", nil)
	rawset(lua_copost_password_paper, "configDict", nil)
end

return lua_copost_password_paper
