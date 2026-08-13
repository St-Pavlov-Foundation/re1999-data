-- chunkname: @modules/logic/versionactivity3_9/bird/config/V3a9BirdConfig.lua

module("modules.logic.versionactivity3_9.bird.config.V3a9BirdConfig", package.seeall)

local V3a9BirdConfig = class("V3a9BirdConfig", BaseConfig)

function V3a9BirdConfig:reqConfigNames()
	return {
		"bird_const"
	}
end

function V3a9BirdConfig:onInit()
	return
end

function V3a9BirdConfig:onConfigLoaded(configName, configTable)
	local funcName = string.format("%sConfigLoaded", configName)
	local configLoadedFunc = self[funcName]

	if configLoadedFunc then
		configLoadedFunc(self, configTable)
	end
end

function V3a9BirdConfig:getBirdConstValue(actId, constId, isValue2, isToNum, defaultValue)
	local actDict = lua_bird_const.configDict and lua_bird_const.configDict[actId] or nil
	local co = actDict and actDict[constId] or nil

	if co then
		if isValue2 then
			return co.value2
		end

		local value = co.value

		if isToNum then
			return tonumber(value)
		end

		return value
	end

	logError(string.format("V3a9BirdConfig:getBirdConstValue error, cfg is nil, actId:%s id:%s", actId, constId))

	return defaultValue
end

V3a9BirdConfig.instance = V3a9BirdConfig.New()

return V3a9BirdConfig
