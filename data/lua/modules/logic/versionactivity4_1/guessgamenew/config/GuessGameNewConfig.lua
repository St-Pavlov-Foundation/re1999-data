-- chunkname: @modules/logic/versionactivity4_1/guessgamenew/config/GuessGameNewConfig.lua

module("modules.logic.versionactivity4_1.guessgamenew.config.GuessGameNewConfig", package.seeall)

local GuessGameNewConfig = class("GuessGameNewConfig", BaseConfig)

function GuessGameNewConfig:ctor()
	self._constConfig = {}
	self._weekRolesConfig = {}
	self._boxGiftConfig = {}
	self._episodeConfig = {}
	self._npcConfig = {}
end

function GuessGameNewConfig:reqConfigNames()
	return {
		"trad_const",
		"trad_gameroles",
		"trad_episode",
		"trad_giftbox",
		"trad_npc"
	}
end

function GuessGameNewConfig:onConfigLoaded(configName, configTable)
	if configName == "trad_const" then
		self._constConfig = configTable
	elseif configName == "trad_gameroles" then
		self._weekRolesConfig = configTable
	elseif configName == "trad_episode" then
		self._episodeConfig = configTable
	elseif configName == "trad_giftbox" then
		self._boxGiftConfig = configTable
	elseif configName == "trad_npc" then
		self._npcConfig = configTable
	end
end

function GuessGameNewConfig:getConstCos()
	return self._constConfig.configDict
end

function GuessGameNewConfig:getConstValue(id)
	if not self._constConfig.configDict[id] then
		return ""
	end

	return self._constConfig.configDict[id].strValue
end

function GuessGameNewConfig:getConstNumberValue(id)
	if not self._constConfig.configDict[id] then
		return 0
	end

	local value = tonumber(self._constConfig.configDict[id].strValue)

	return value or 0
end

function GuessGameNewConfig:getCtrlCo(actId)
	actId = actId or VersionActivity4_1Enum.ActivityId.GuessGameNew

	local ctrlCo = Activity234Config.instance:getCtrlCo(actId)

	return ctrlCo
end

function GuessGameNewConfig:getWeekRoleCo(week)
	return self._weekRolesConfig.configDict[week]
end

function GuessGameNewConfig:getBonusCos(actId)
	actId = actId or VersionActivity4_1Enum.ActivityId.GuessGameNew

	local bonusCos = Activity234Config.instance:getBonusCos(actId)

	return bonusCos
end

function GuessGameNewConfig:getBonusCo(bonusId, actId)
	actId = actId or VersionActivity4_1Enum.ActivityId.GuessGameNew

	local bonusCo = Activity234Config.instance:getBonusCo(bonusId, actId)

	return bonusCo
end

function GuessGameNewConfig:getEpisodeCo(episodeId)
	return self._episodeConfig.configDict[episodeId]
end

function GuessGameNewConfig:getBoxGiftCos()
	return self._boxGiftConfig.configDict
end

function GuessGameNewConfig:getBoxGiftCo(giftId)
	return self._boxGiftConfig.configDict[giftId]
end

function GuessGameNewConfig:getNpcCo(npcId)
	return self._npcConfig.configDict[npcId]
end

GuessGameNewConfig.instance = GuessGameNewConfig.New()

return GuessGameNewConfig
