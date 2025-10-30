-- chunkname: @modules/logic/summon/model/SummonLuckyBagMO.lua

module("modules.logic.summon.model.SummonLuckyBagMO", package.seeall)

local SummonLuckyBagMO = pureTable("SummonLuckyBagMO")

function SummonLuckyBagMO:ctor()
	self.luckyBagId = 0
	self.summonTimes = 0
	self.openedTimes = 0
end

function SummonLuckyBagMO:update(info)
	self.luckyBagId = info.luckyBagId or 0
	self.summonTimes = info.count or 0
	self.openedTimes = info.openLBTimes or 0
end

function SummonLuckyBagMO:isGot()
	return self.luckyBagId ~= nil and self.luckyBagId ~= 0 or self.openedTimes > 0
end

function SummonLuckyBagMO:isOpened()
	return self.openedTimes > 0
end

return SummonLuckyBagMO
