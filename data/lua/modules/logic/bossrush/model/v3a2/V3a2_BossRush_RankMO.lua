-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_RankMO.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_RankMO", package.seeall)

local V3a2_BossRush_RankMO = pureTable("V3a2_BossRush_RankMO")

function V3a2_BossRush_RankMO:initMO(config)
	self.config = config
	self.isNoraml = true
	self.playerLevel = config.playerLevel
	self.season = config.season
end

function V3a2_BossRush_RankMO:initExp(preExp, needExp)
	self.preExp = preExp
	self.totalNeedExp = needExp
end

function V3a2_BossRush_RankMO:setInfo(playerLevel, gainMilestoneLevel)
	self.finishClaim = gainMilestoneLevel >= self.config.playerLevel
	self.canClaim = not self.finishClaim and playerLevel >= self.config.playerLevel
end

function V3a2_BossRush_RankMO:onClaim(isFinish)
	self.finishClaim = isFinish
end

function V3a2_BossRush_RankMO:setLock(isShowNextLine, level, season)
	self.isNoraml = false
	self.isShowNextLine = isShowNextLine
	self.playerLevel = level
	self.season = season
end

function V3a2_BossRush_RankMO:setPreRank(rank)
	self.preRank = rank
end

return V3a2_BossRush_RankMO
