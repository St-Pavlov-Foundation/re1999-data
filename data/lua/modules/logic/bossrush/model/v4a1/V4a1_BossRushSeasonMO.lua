-- chunkname: @modules/logic/bossrush/model/v4a1/V4a1_BossRushSeasonMO.lua

module("modules.logic.bossrush.model.v4a1.V4a1_BossRushSeasonMO", package.seeall)

local V4a1_BossRushSeasonMO = pureTable("V4a1_BossRushSeasonMO")

function V4a1_BossRushSeasonMO:onInit(co)
	self.season = co.id
	self.co = co
	self.expMaterial = string.splitToNumber(co.expMaterial, "#")

	self:refreshLevel(0, 0, 0)

	self.exp = 0
	self.level = 0
	self.claimLevel = 0
end

function V4a1_BossRushSeasonMO:refreshLevel(level)
	self.level = level or 0
end

function V4a1_BossRushSeasonMO:refreshClaimLevel(claimLevel)
	self.claimLevel = claimLevel or 0
end

function V4a1_BossRushSeasonMO:isCanClaimRankBonus()
	return self.claimLevel < self.level
end

return V4a1_BossRushSeasonMO
