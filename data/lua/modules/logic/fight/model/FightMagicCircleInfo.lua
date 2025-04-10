module("modules.logic.fight.model.FightMagicCircleInfo", package.seeall)

slot0 = pureTable("FightMagicCircleInfo")

function slot0.ctor(slot0)
	slot0.magicCircleId = nil
end

function slot0.refreshData(slot0, slot1)
	slot0.magicCircleId = slot1.magicCircleId
	slot0.round = slot1.round
	slot0.createUid = slot1.createUid
	slot0.electricLevel = slot1.electricLevel
	slot0.electricProgress = slot1.electricProgress
end

function slot0.deleteData(slot0, slot1)
	if slot1 == slot0.magicCircleId then
		slot0.magicCircleId = nil

		return true
	end
end

function slot0.clear(slot0)
	slot0.magicCircleId = nil
	slot0.round = nil
	slot0.createUid = nil
	slot0.electricLevel = nil
	slot0.electricProgress = nil
end

return slot0
