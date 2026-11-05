-- chunkname: @modules/configs/excel2json/lua_paper_trail.lua

module("modules.configs.excel2json.lua_paper_trail", package.seeall)

local lua_paper_trail = {}
local fields = {
	serial = 3,
	notShow = 2,
	color = 4,
	type = 1
}
local primaryKey = {
	"type"
}
local mlStringKey = {}
local _configList, _configDict
local configPath = "configs.paper_trail_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = JsonToLuaParser.parse(config, fields, primaryKey, mlStringKey)

	rawset(lua_paper_trail, "configList", _configList)
	rawset(lua_paper_trail, "configDict", _configDict)
end

setmetatable(lua_paper_trail, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_paper_trail.clearConfig()
	_configList, _configDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_paper_trail, "configList", nil)
	rawset(lua_paper_trail, "configDict", nil)
end

return lua_paper_trail
