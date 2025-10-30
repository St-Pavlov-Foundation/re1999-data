-- chunkname: @modules/logic/summon/model/SummonMainPoolMO.lua

module("modules.logic.summon.model.SummonMainPoolMO", package.seeall)

local SummonMainPoolMO = pureTable("SummonMainPoolMO")

function SummonMainPoolMO:init(info)
	self.id = info.poolId
	self.luckyBagMO = SummonLuckyBagMO.New()
	self.customPickMO = SummonCustomPickMO.New()

	self:update(info)
end

function SummonMainPoolMO:update(info)
	self.offlineTime = info.offlineTime or 0
	self.onlineTime = info.onlineTime or 0
	self.haveFree = info.haveFree or false
	self.usedFreeCount = info.usedFreeCount or 0

	if info.luckyBagInfo then
		self.luckyBagMO:update(info.luckyBagInfo)
	end

	if info.spPoolInfo then
		self.customPickMO:update(info.spPoolInfo)
	end

	self.discountTime = info.discountTime or 0
	self.canGetGuaranteeSRCount = info.canGetGuaranteeSRCount or 0
	self.guaranteeSRCountDown = info.guaranteeSRCountDown or 0
	self.summonCount = info.summonCount or 0
end

function SummonMainPoolMO:isOpening()
	if self.offlineTime == 0 and self.onlineTime == 0 then
		return true
	end

	local serverTime = ServerTime.now()

	return serverTime >= self.onlineTime and serverTime <= self.offlineTime
end

function SummonMainPoolMO:isHasProgressReward()
	local numsList = SummonConfig.instance:getProgressRewardsByPoolId(self.id)
	local canRewardCount = 0
	local rewardCount = self.customPickMO:getRewardCount() or 0

	if numsList and #numsList > 0 then
		for i, nums in ipairs(numsList) do
			if nums[1] <= self.summonCount then
				canRewardCount = canRewardCount + 1
			end
		end
	end

	return rewardCount < canRewardCount
end

return SummonMainPoolMO
