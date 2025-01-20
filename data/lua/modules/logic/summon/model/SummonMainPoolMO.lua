module("modules.logic.summon.model.SummonMainPoolMO", package.seeall)

slot0 = pureTable("SummonMainPoolMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.poolId
	slot0.luckyBagMO = SummonLuckyBagMO.New()
	slot0.customPickMO = SummonCustomPickMO.New()

	slot0:update(slot1)
end

function slot0.update(slot0, slot1)
	slot0.offlineTime = slot1.offlineTime or 0
	slot0.onlineTime = slot1.onlineTime or 0
	slot0.haveFree = slot1.haveFree or false
	slot0.usedFreeCount = slot1.usedFreeCount or 0

	if slot1.luckyBagInfo then
		slot0.luckyBagMO:update(slot1.luckyBagInfo)
	end

	if slot1.spPoolInfo then
		slot0.customPickMO:update(slot1.spPoolInfo)
	end

	slot0.discountTime = slot1.discountTime or 0
	slot0.canGetGuaranteeSRCount = slot1.canGetGuaranteeSRCount or 0
	slot0.guaranteeSRCountDown = slot1.guaranteeSRCountDown or 0
end

function slot0.isOpening(slot0)
	if slot0.offlineTime == 0 and slot0.onlineTime == 0 then
		return true
	end

	return slot0.onlineTime <= ServerTime.now() and slot1 <= slot0.offlineTime
end

return slot0
