module("modules.logic.fight.model.data.FightBloodPoolDataMgr", package.seeall)

slot0 = FightDataClass("FightBloodPoolDataMgr", FightDataMgrBase)

function slot0.onConstructor(slot0)
	slot0.playedSkill = false
end

function slot0.onCancelOperation(slot0)
	if slot0.playedSkill then
		slot0.playedSkill = false
	end

	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnCancelPlayCard)
end

function slot0.playBloodPoolCard(slot0)
	slot0.playedSkill = true

	FightController.instance:dispatchEvent(FightEvent.BloodPool_OnPlayCard)
end

function slot0.checkPlayedCard(slot0)
	return slot0.playedSkill
end

return slot0
