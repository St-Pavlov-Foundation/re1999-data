-- chunkname: @modules/logic/bossrush/model/BossRushBossDetailMO.lua

module("modules.logic.bossrush.model.BossRushBossDetailMO", package.seeall)

local BossRushBossDetailMO = pureTable("BossRushBossDetailMO")

function BossRushBossDetailMO:onInit(co)
	self.actId = co.activityId
	self.stage = co.stage
	self.highestPoint = 0
	self.doubleNum = 0
	self.layer4TotalPoint = 0
	self.layer4HighestPoint = 0
	self.spHighestPoint = 0
	self.spItemTypeIds = 0
	self.latestPoint = 0
	self.actModeTeam = V3a9_BossRushTeamMO.New()
	self.stageCO = co

	local episodeCOs = BossRushConfig.instance:getEpisodeStages(self.stage, self.actId)

	self.episodeCO = episodeCOs and episodeCOs[1]
	self.season = co.version < 1 and 1 or co.version
	self.hasGetBonusIds = {}
end

function BossRushBossDetailMO:initInfo(actId, info)
	self.actId = actId
	self.stage = info and info.bossId
	self.totalPoint = info and info.totalPoint or 0
	self.highestPoint = info and info.highestPoint or 0
	self.doubleNum = info and info.doubleNum or 0
	self.layer4TotalPoint = info and info.layer4TotalPoint or 0
	self.layer4HighestPoint = info and info.layer4HighestPoint or 0
	self.spHighestPoint = info and info.spHighestPoint or 0
	self.spItemTypeIds = info and info.spItemTypeIds or 0
	self.latestPoint = info and info.latestPoint or 0

	if not self.actModeTeam then
		self.actModeTeam = V3a9_BossRushTeamMO.New()
	end

	if info and info.actModeTeam then
		self.actModeTeam:initInfo(self.actId, self.stage, info.actModeTeam)
	end

	self.stageCO = BossRushConfig.instance:getStageCO(self.stage, actId)

	local episodeCOs = BossRushConfig.instance:getEpisodeStages(self.stage, actId)

	self.episodeCO = episodeCOs and episodeCOs[1]
	self.hasGetBonusIds = {}

	if info and info.hasGetBonusIds then
		for _, v in ipairs(info.hasGetBonusIds) do
			self.hasGetBonusIds[v] = true
		end
	end
end

function BossRushBossDetailMO:onRefresh(msg)
	self.latestPoint = 0

	self.actModeTeam:refreshTeamInfo(msg.actModeTeam)
end

function BossRushBossDetailMO:isChallenge()
	if self.latestPoint > 0 then
		return true
	end
end

function BossRushBossDetailMO:isOpen()
	return ServerTime.now() >= self:getStageOpenServerTime()
end

function BossRushBossDetailMO:isNewUnlock()
	if not self:isOpen() then
		return false
	end

	return BossRushRedModel.instance:isNewUnlockActStage(self.actId, self.stage)
end

function BossRushBossDetailMO:setIsNewUnlockStage(isNew)
	BossRushRedModel.instance:setIsNewUnlockActStage(self.actId, self.stage, isNew)
end

function BossRushBossDetailMO:getStageOpenServerTime()
	local openDay = self.episodeCO and self.episodeCO.openDay or 1
	local actMo = ActivityModel.instance:getActMO(self.actId)
	local openTs = actMo and actMo:getRealStartTimeStamp() or 0

	return openTs + (openDay - 1) * 86400
end

function BossRushBossDetailMO:getAddBondGroupId()
	return self.actModeTeam:getAddBondGroupId()
end

function BossRushBossDetailMO:getTotalPoint()
	return self.totalPoint or 0
end

function BossRushBossDetailMO:getRewardMaxTotalScore()
	if not self._scheduleRewardMos then
		self._scheduleRewardMos = self:getScheduleViewRewardList()
	end

	return self._maxTotalScore
end

function BossRushBossDetailMO:getScheduleViewRewardList()
	self._scheduleRewardMos = nil

	if not self._scheduleRewardMos then
		self._scheduleRewardMos = {}
		self._maxTotalScore = 0

		local cos = lua_activity128_rewards.configDict[self.actId]

		if cos then
			for _, co in ipairs(cos) do
				if co.stage == self.stage then
					if self._maxTotalScore < co.rewardPointNum then
						self._maxTotalScore = co.rewardPointNum
					end

					local mo = {
						rewardId = co.id,
						stageRewardCO = co,
						stage = co.stage
					}

					table.insert(self._scheduleRewardMos, mo)
				end
			end
		end
	end

	local cur = self:getTotalPoint()

	for i, mo in ipairs(self._scheduleRewardMos) do
		mo.isGot = self:hasGetBonus(mo.rewardId)
		mo.isAlready = cur >= mo.stageRewardCO.rewardPointNum
	end

	return self._scheduleRewardMos
end

function BossRushBossDetailMO:getFinishScheduleRewardCount()
	local mos = self:getScheduleViewRewardList()
	local count = 0

	for _, mo in ipairs(mos) do
		if not mo.isGot and mo.isAlready then
			count = count + 1
		end
	end

	return count
end

function BossRushBossDetailMO:refreshHasGetBonusIds(rewardId)
	if not self.hasGetBonusIds then
		self.hasGetBonusIds = {}
	end

	self.hasGetBonusIds[rewardId] = true
end

function BossRushBossDetailMO:hasGetBonus(rewardId)
	return self.hasGetBonusIds and self.hasGetBonusIds[rewardId]
end

return BossRushBossDetailMO
