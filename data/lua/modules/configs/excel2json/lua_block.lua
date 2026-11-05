-- chunkname: @modules/configs/excel2json/lua_block.lua

module("modules.configs.excel2json.lua_block", package.seeall)

local lua_block = {}
local fields = {
	prefabPath = 2,
	mainRes = 4,
	category = 5,
	resourceIds = 3,
	defineId = 1
}
local primaryKey = {
	"defineId"
}
local mlStringKey = {}
local propertyNames = {
	"blockType",
	"waterType"
}
local _configList, _configDict, _propertyList, _propertyDict
local configPath = "configs.block_config"

local function onConfigLoad()
	if _configList then
		return
	end

	local config = LuaUtil.requireConfig(configPath)

	_configList, _configDict = lua_block.json_parse(config)
	_propertyList, _propertyDict = lua_block.json_property(config, propertyNames)

	rawset(lua_block, "configList", _configList)
	rawset(lua_block, "configDict", _configDict)
	rawset(lua_block, "propertyList", _propertyList)
	rawset(lua_block, "propertyDict", _propertyDict)
end

setmetatable(lua_block, {
	__index = function(t, k)
		onConfigLoad()

		return rawget(t, k)
	end
})

function lua_block.clearConfig()
	_configList, _configDict = nil
	_propertyList, _propertyDict = nil

	LuaUtil.clearTable(configPath)
	rawset(lua_block, "configList", nil)
	rawset(lua_block, "configDict", nil)
	rawset(lua_block, "propertyList", nil)
	rawset(lua_block, "propertyDict", nil)
end

function lua_block.json_parse(json)
	local configList = {}
	local configDict = {}

	for _, cfg in ipairs(json) do
		table.insert(configList, cfg)

		configDict[cfg.defineId] = cfg

		if cfg.category == cjson.null then
			cfg.category = nil
		end

		local countDict = {}

		cfg.resIdCountDict = countDict

		for _r, resId in ipairs(cfg.resourceIds) do
			countDict[resId] = (countDict[resId] or 0) + 1
		end
	end

	return configList, configDict
end

function lua_block.json_property(json, propertyNames)
	local propertyList = {}
	local propertyDict = {}

	for _, propertyName in ipairs(propertyNames) do
		local tempList = {}
		local tempDict = {}

		propertyList[propertyName] = tempList
		propertyDict[propertyName] = tempDict

		for __, cfg in ipairs(json) do
			local propertyValue = cfg[propertyName]

			if propertyValue and not tempDict[propertyValue] then
				tempDict[propertyValue] = propertyValue

				table.insert(tempList, propertyValue)
			end
		end

		logNormal(string.format("lua_block.json_property [%s]:%s,", propertyName, table.concat(tempList, ",")))
	end

	return propertyList, propertyDict
end

return lua_block
