-- chunkname: @modules/logic/versionactivity4_1/peishita/config/PeiShiTaConfig.lua

module("modules.logic.versionactivity4_1.peishita.config.PeiShiTaConfig", package.seeall)

local PeiShiTaConfig = class("PeiShiTaConfig", Activity220SimpleBaseConfig)

function PeiShiTaConfig:actId()
	if self.__activityId then
		return self.__activityId
	end

	self.__activityId = VersionActivity4_1Enum.ActivityId.PeiShiTa

	return self.__activityId
end

PeiShiTaConfig.instance = PeiShiTaConfig.New()

return PeiShiTaConfig
