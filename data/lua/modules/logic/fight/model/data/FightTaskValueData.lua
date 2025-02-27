module("modules.logic.fight.model.data.FightTaskValueData", package.seeall)

slot0 = FightDataClass("FightTaskValueData")

function slot0.onConstructor(slot0, slot1)
	slot0.index = slot1.index
	slot0.progress = slot1.progress
	slot0.maxProgress = slot1.maxProgress
	slot0.finished = slot1.finished
end

return slot0
