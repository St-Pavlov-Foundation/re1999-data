-- chunkname: @modules/logic/versionactivity4_1/arcadesurvivor/model/reward/ArcadeSurvivorRewardMO.lua

module("modules.logic.versionactivity4_1.arcadesurvivor.model.reward.ArcadeSurvivorRewardMO", package.seeall)

local ArcadeSurvivorRewardMO = class("ArcadeSurvivorRewardMO")

function ArcadeSurvivorRewardMO:ctor(cfg)
	self.cfg = cfg
	self.id = cfg.id
	self.score = cfg.score
end

function ArcadeSurvivorRewardMO:onGain(isGain)
	self._isGain = isGain
end

function ArcadeSurvivorRewardMO:getId()
	return self.id
end

function ArcadeSurvivorRewardMO:getCfg()
	return self.cfg
end

function ArcadeSurvivorRewardMO:getScore()
	return self.score
end

function ArcadeSurvivorRewardMO:isGainReward()
	return self._isGain
end

function ArcadeSurvivorRewardMO:getRewardState()
	if self._isGain then
		return ArcadeSurvivorHallEnum.RewardItemStatus.Gained
	end

	local needScore = self:getScore()
	local curScore = ArcadeSurvivorOutSideModel.instance:getScore()

	if needScore <= curScore then
		return ArcadeSurvivorHallEnum.RewardItemStatus.CanGet
	end

	return ArcadeSurvivorHallEnum.RewardItemStatus.Normal
end

return ArcadeSurvivorRewardMO
