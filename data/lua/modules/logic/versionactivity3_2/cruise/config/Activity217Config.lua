﻿-- chunkname: @modules/logic/versionactivity3_2/cruise/config/Activity217Config.lua

module("modules.logic.versionactivity3_2.cruise.config.Activity217Config", package.seeall)

local Activity217Config = class("Activity217Config", BaseConfig)

function Activity217Config:ctor()
	self._controlConfig = nil
	self._bonusConfig = nil
end

function Activity217Config:reqConfigNames()
	return {
		"activity217_control",
		"activity217_bonus"
	}
end

function Activity217Config:onConfigLoaded(configName, configTable)
	if configName == "activity217_control" then
		self._controlConfig = configTable
	elseif configName == "activity217_bonus" then
		self._bonusConfig = configTable
	end
end

function Activity217Config:getControlCO(controlId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	return self._controlConfig.configDict[actId][controlId]
end

function Activity217Config:getControlCos(actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	return self._controlConfig.configDict[actId]
end

function Activity217Config:getBonusCO(episodeId, actId)
	actId = actId or VersionActivity3_2Enum.ActivityId.CruiseTripleDrop

	return self._bonusConfig.configDict[actId][episodeId]
end

Activity217Config.instance = Activity217Config.New()

return Activity217Config
